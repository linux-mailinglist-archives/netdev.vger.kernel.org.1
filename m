Return-Path: <netdev+bounces-21200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5F762CC4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C801C21116
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34958480;
	Wed, 26 Jul 2023 07:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F003846C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:11:27 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2611BE8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:11:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so63317275e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690355483; x=1690960283;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uW90uN3Uv4IyAHZTQSJo/qaZvswI3M0KnrCHmxMwMk=;
        b=B2/YZQrSuaxzAEoABRIVPsRO9Wt3zQAGhNfxwTuQd2yMQp0SsspzJ229E4zjvPEDCI
         /IVo/PsuR+RZNCVC7uzeMFlGvzKP7SGRr/p+cPstrFZnvPPlelb7c+5PRRnhUdRPZ6MU
         qMT4IXX4biNmQ2Ym6chTT8U7JJvjIE3SGSIPKJsHh3SB3JSzxtYlSt94TTSKS/akfpc8
         Qb1cki1H3eQSZAx5qpZNd9bU31oq9dnsSfJJoxL0LBosxRO/5ROQ+80RHqCz7j5W2gEm
         wY9h+XE60bZfbnakFMOVqv7D+N6/m/QVmxpItVOSMepD4zALeVyPd1ZiZ/Nw49mBZTAO
         CKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355483; x=1690960283;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uW90uN3Uv4IyAHZTQSJo/qaZvswI3M0KnrCHmxMwMk=;
        b=Zc2IIv0CvqRVB9wcfRJM8BnhMuONY7YRnk5C1vS6FO2xKeQU0YUhY4IenTbNzXtbv/
         WAvwQl5EGlBpmUZdH/5ENfc0TLI50HrDwq6xyhOJEhyUo/Kq3BozJ7rzhHTo78tuTdnc
         kbQYURVbREHxeS7c6BI7tO9XEUu/daCBKF/HFAquxGv3LylvK8QNF6AcHkqY+Sx9IdGl
         tU0APJgf7kvobSgTY5h5fTjKfrVvbGL+PiPf7UAccxWtfvPXYgDJ0MSJaVVDaLVRWiD+
         Au62RsEhfwUAlfNLbLsiw5bVetUEJKxpmkPnTrXXqbbA30pd7I3RW4Xs9P4Xw+zdydJq
         x1Mg==
X-Gm-Message-State: ABy/qLYyqzS1H5OWSfuk8Fyl5K7psdGX/7agQI2EhVNCDgoor0vS0kAX
	Ce6HgkH+JDR6PlDznwg2fdfuZCy52Ns=
X-Google-Smtp-Source: APBJJlHupsTsO4trxUufCmHH7r2NwnOuqb6C9OhAwwxuC3zhIeDzr577QqlAEadsqr5s3+V85pjp4w==
X-Received: by 2002:a05:600c:22da:b0:3fd:2dd9:6d58 with SMTP id 26-20020a05600c22da00b003fd2dd96d58mr681929wmg.26.1690355483092;
        Wed, 26 Jul 2023 00:11:23 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c044f00b003fbb1a9586esm1155419wmb.15.2023.07.26.00.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jul 2023 09:11:22 +0200
Message-Id: <CUBX0CEWRC2S.1PMUD29FODN5J@syracuse>
Cc: <netdev@vger.kernel.org>
Subject: Re: [iproute2] bridge: link: allow filtering on bridge name
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
X-Mailer: aerc 0.15.1
References: <20230725092242.3752387-1-nico.escande@gmail.com>
 <20230725093725.6d52cc03@hermes.local>
 <CUBL17I9Z3W5.1XR1LVI9CRDDU@syracuse>
 <20230725191605.3ca8e599@hermes.local>
In-Reply-To: <20230725191605.3ca8e599@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Jul 26, 2023 at 4:16 AM CEST, Stephen Hemminger wrote:
>
> Leave it there for now. Only Linux uses the term master.
> FreeBSD and other use the term adding interface to bridge (addm)
>
> IEEE uses the term relay mostly.
>
> You won't find the terms master/slave in any current spec.
>
> > On another note, there is a slight indentation problem in the new if in
> > print_linkinfo(), if that can be corrected when the patch gets picked u=
p that
> > would be perfect, otherwise I can send a v2.
>
> Send a v2, that would be easier

OK, I'll get right on it.

