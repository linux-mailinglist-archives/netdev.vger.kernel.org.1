Return-Path: <netdev+bounces-21722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28617646F9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B98A1C214F2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260143D68;
	Thu, 27 Jul 2023 06:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C31FDE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:38:47 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38992116
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:38:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so1031521e87.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690439924; x=1691044724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjG9dr6v6sg4y+tnYA+wpoHL8pZ1js8jvNiHTQ8DbDw=;
        b=WU08/xhBm0Wi+HsSuPsITyjj50K0RjrWUbGnvsL85cnvFlS3e0lnfZxeGqBKnaE9lL
         lTqT+uqo0lcPD1D084sDJtFZ4WnmmS0F5w0HU3F8ynZ6DC/f0WL8r2MnILFj5wrrsd0a
         YbmoOVMaWJzgwEkgMTPIB+C3mhR8z75Ln/b47BfEEDrzt0KuhgKg/x8zRgG4kcqwwlAA
         9MkvfNjdLDQVDsWrSltXEts2+7i5oDJmK+OCuyS5ps3byMnWgvoCls40/XDKFH0VbNro
         tHW1lcZgkiie4nCD2g7m8fIRt+irO4hvTiR2BbAp+tjnR7iiQwuz00Ffkc0ymVWOHCij
         RUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690439924; x=1691044724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjG9dr6v6sg4y+tnYA+wpoHL8pZ1js8jvNiHTQ8DbDw=;
        b=FXfhOQDrUzm6jk1nbrP5vCtXB0nwHYD0dZXlZ1u4ALhNoj923O5jjMfxSIIp2QTGCj
         X7aZOfXVMFGtOzZOtXzF3gUYg1RdGdZULvP3fXRRfLpN0Qr+HXYV7BIxDk+mXzlI+l2E
         bMZZBNEQQla5uCSu+gEqVvOrAKLbO9ckyDdZmt0LDMm6TPRkiVcEVI9OYP8QR+hoqcah
         knIho+tZANQfe3o2H0hZ1+m7hDQagO8kQFBmz4q5M9lbMQ4jb9CzkNOm8gK4F9S1+OAm
         d7naz2yu3juymA2xHGqr3qEaWPOmilWubH2IWrIgIhhErpO2A8n4X917HqhAzFaqvcOc
         5bfw==
X-Gm-Message-State: ABy/qLahnBjl1lDEzc4R5yJcm9d6ErG6lWJ8fvM/D5egdXCuTmtjMkJU
	VIOwQeGiB5ZWgAD2E0rRfaU=
X-Google-Smtp-Source: APBJJlGWAILA17VJ5mmxTdEQkGcqvKnnQUv5z300FIf5RrPLREljJ2l1HcmzNt57AQXJp1psUn3l5g==
X-Received: by 2002:a05:6512:238f:b0:4f6:1779:b1c1 with SMTP id c15-20020a056512238f00b004f61779b1c1mr1321559lfv.48.1690439923759;
        Wed, 26 Jul 2023 23:38:43 -0700 (PDT)
Received: from tycho (p200300c1c70f2800ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c70f:2800:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id t23-20020a1c7717000000b003fbb9339b29sm3706465wmi.42.2023.07.26.23.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:38:43 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Thu, 27 Jul 2023 08:38:41 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Zahari Doychev <zdoychev@maxlinear.com>, 
	Simon Horman <simon.horman@corigine.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH v2 net] net: flower: fix stack-out-of-bounds in
 fl_set_key_cfm()
Message-ID: <sea4v7yibt2u6ru4fvist6cgatg4okrb4mmlu62m4xx7sh3yud@lzxwshuvlcbc>
References: <20230726145815.943910-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145815.943910-1-edumazet@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 02:58:15PM +0000, Eric Dumazet wrote:
> Typical misuse of
> 
> 	nla_parse_nested(array, XXX_MAX, ...);
> 
> array must be declared as
> 
> 	struct nlattr *array[XXX_MAX + 1];
> 
> v2: Based on feedbacks from Ido Schimmel and Zahari Doychev,
> I also changed TCA_FLOWER_KEY_CFM_OPT_MAX and cfm_opt_policy
> definitions.

[...]

Reviewed-by: Zahari Doychev <zdoychev@maxlinear.com>

thanks

