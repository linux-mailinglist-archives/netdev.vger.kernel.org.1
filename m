Return-Path: <netdev+bounces-36048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A297ACAB5
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 18:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id BFED91F23248
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB2D51C;
	Sun, 24 Sep 2023 16:09:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3221933F2
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 16:09:30 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FB83
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:09:29 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so955934241.3
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695571768; x=1696176568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ3KNicffbtqnuq68wxXV4ExBesCY5NfmO2MdgKIHJw=;
        b=bY3xX1cWADKBZypgKjcI3o17KZuPIJ5crg2kbOuq8MzloLBA84Njc2LDYjfypfGgD+
         Ft6ayr1bY0CvEZ3Ilz2hR0Dl+bG9Y3zUXrms5RVrThm3bZnK1OFVDwp3lqVijQMGU2L3
         yZFBcb19LUVFzNX3xWCCxmNVBsO5zogjsovJHw2cbVVSMSzV4B1Mvhd8iamfSuGUJgVg
         Ql4SxtP5lYxdqKZhmqGDPeHKG14zhZr9k76eJ+vEkmIevfRmKKk/wQWGKpd6Ab688CXL
         mijdQDaHYFks/61Mkz+TsuTpIhdv4EIL0aiqa8TXw9FA0r/rKGZrhkYmp/mEunQKD2wL
         jiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695571768; x=1696176568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ3KNicffbtqnuq68wxXV4ExBesCY5NfmO2MdgKIHJw=;
        b=b8eNDGQpgHWFPfxMlBfghu0Dj9axaJt1IbAdwDeJEsyoiGbMsOT/hGOxG6ajQb+Rq6
         Mm/Pmlcmlk35u9S1MfXHj0fd+gqDXyQ2HZPvbjS1m7qmJR0mAQLnQgEc9qtYUpcjnED7
         jKV09Qe1WQTKS02u8J+ZpflLrxBkrLflvv58U827VsKXjCk3jZ5VKfyandgwkmfxyTH5
         w/qY4PeogIuE49dhndsjTkezaTUEMqJ69YtiGaU9xIY52b8wjsqUIJHufYqlIKuGRTTb
         6ISQylc1IlIyl2bexXEuGt3Zz3FtOJfbLHSXd/9LcrQ6GCHNHhmVL64UNQzLpT+QLMC8
         q+pw==
X-Gm-Message-State: AOJu0YwJ4Jtjg7FF/6K9abOh4qGsE9VRMa7RNHrSmqUx9Rc1cf9u/4Hd
	u5Lj7mM+EBaq4nK1sKhG5mUCgPGVMdoEYrWUvFbvHg==
X-Google-Smtp-Source: AGHT+IFM+0WKQGWL+wgnvVZTOVh20p0MFRcDFGQl0RPsFmil5trWJ2/oYz05UqHGqYCp2vBKmKBmr+h67dy1bWQMQN8=
X-Received: by 2002:a05:6102:97:b0:44d:5b62:bcd5 with SMTP id
 t23-20020a056102009700b0044d5b62bcd5mr2572414vsp.23.1695571768084; Sun, 24
 Sep 2023 09:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com> <20230922220356.3739090-3-edumazet@google.com>
In-Reply-To: <20230922220356.3739090-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 24 Sep 2023 12:09:11 -0400
Message-ID: <CADVnQym4suwOn7w7zRHMjzEpQTzDwU5ZanndhJMj2s+4Rx32OQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] tcp_metrics: properly set tp->snd_ssthresh
 in tcp_init_metrics()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 6:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We need to set tp->snd_ssthresh to TCP_INFINITE_SSTHRESH
> in the case tcp_get_metrics() fails for some reason.
>
> Fixes: 9ad7c049f0f7 ("tcp: RFC2988bis + taking RTT sample from 3WHS for t=
he passive open side")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---


Acked-by: Neal Cardwell <ncardwell@google.com>

neal

