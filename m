Return-Path: <netdev+bounces-30231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0278680F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B391C208EA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255924554;
	Thu, 24 Aug 2023 07:04:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6E24553
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:04:55 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144EE6F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:04:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313e742a787so331436f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692860692; x=1693465492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wRx019sADz7VrVAreOpz8rm5QxkCuZQY4e51+r3JkRk=;
        b=n7CR6BAIKD4TFgNebeZTFxDwEsVeuvdI0zZ/xNGKhti2LdQ/GsdwIwOdb98IqryNrH
         37ML2bkBR1C91bkNgHYjiJ6txR9WZqTKgRKst9xtMu76NxJuvgip2LwINFKQgQMB8Dy7
         b/TpcepHMSV8ArhN0k8THPdPKte0dfMaNKm5H6ukfi18CS7le+tCvmlkjeZAy81eSSId
         WAieSnxC/mDQ6M7INCVzY9qxjqAiNKMu4byF4n3E8yLnkBu09qH9kr7cX82rNYNfYMmN
         54cn3CP+g+63dPhcsXW7g4e2T0sB/9opumFDoOQf5KMcIh4Sv+pE97mXAduX8HHxTfOp
         S5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692860692; x=1693465492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRx019sADz7VrVAreOpz8rm5QxkCuZQY4e51+r3JkRk=;
        b=H/lc5KoPTKkNUEzVhxSsBA3IZSqlQkOwAoz2VHBI3ui/IOwwQy9CiuQlhRexDRvapL
         3ouv3T8GLBGSKyv34+X2ePOQ/lvvtNiuwYEG9qZJg4L8QWBipyR0YG6q30/vGdxhPGo6
         pv6ITpynPUC/uTf2ifEEMYukd4BvC+J4hPjehCl+CJtEc9B5YTgZK3CFcdUyLL76OgP+
         IE1YM8mNtdnrjI36OQ360wLdNbdYn5YiM+W2d3zCpk8R1RTaTVCzpRoHSHvx5RnTpVk1
         5V07egjDf6Okns863/siE4QpSbjby4PZssYqcGMX78fOGaSWxP/NHlGxwXCabXhYa0Cr
         jZZw==
X-Gm-Message-State: AOJu0YwX5SJMSlh8CTk451uAJSr8baK5+ZN4erALgJrm2leoKHkqfIoB
	QUqOpukVV+rCRPEaxfv6r5N0zg==
X-Google-Smtp-Source: AGHT+IFF7Be7qvROB9L70bjLXpNnOgB18klQfnMIlbAvECf66L417p5FccYryK4pwK44TfpU+4NugQ==
X-Received: by 2002:adf:ffc4:0:b0:319:8161:bfed with SMTP id x4-20020adfffc4000000b003198161bfedmr10994255wrs.33.1692860692514;
        Thu, 24 Aug 2023 00:04:52 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id d17-20020adfef91000000b0031ad5fb5a0fsm21453629wro.58.2023.08.24.00.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 00:04:51 -0700 (PDT)
Date: Thu, 24 Aug 2023 09:04:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Zhang, Xuejun" <xuejun.zhang@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	madhu.chittim@intel.com, qi.z.zhang@intel.com,
	anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v4 0/5] iavf: Add devlink and devlink rate
 support'
Message-ID: <ZOcBEt59zHW9qHhT@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com>
 <ZORRzEBcUDEjMniz@nanopsycho>
 <20230822081255.7a36fa4d@kernel.org>
 <ZOTVkXWCLY88YfjV@nanopsycho>
 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 23, 2023 at 09:13:34PM CEST, xuejun.zhang@intel.com wrote:
>
>On 8/22/2023 8:34 AM, Jiri Pirko wrote:
>> Tue, Aug 22, 2023 at 05:12:55PM CEST,kuba@kernel.org  wrote:
>> > On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
>> > > NACK! Port function is there to configure the VF/SF from the eswitch
>> > > side. Yet you use it for the configureation of the actual VF, which is
>> > > clear misuse. Please don't
>> > Stating where they are supposed to configure the rate would be helpful.
>> TC?
>
>Our implementation is an extension to this commit 42c2eb6b1f43 ice: Implement
>devlink-rate API).
>
>We are setting the Tx max & share rates of individual queues in a VF using
>the devlink rate API.
>
>Here we are using DEVLINK_PORT_FLAVOUR_VIRTUAL as the attribute for the port
>to distinguish it from being eswitch.

I understand, that is a wrong object. So again, you should use
"function" subobject of devlink port to configure "the other side of the
wire", that means the function related to a eswitch port. Here, you are
doing it for the VF directly, which is wrong. If you need some rate
limiting to be configured on an actual VF, use what you use for any
other nic. Offload TC.

