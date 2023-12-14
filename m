Return-Path: <netdev+bounces-57334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA0812E4A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437CA28292E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F1405D2;
	Thu, 14 Dec 2023 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN+UZ2+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F5DB7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3360ae1b937so4123353f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552366; x=1703157166; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkUIKGfxi4N39L2w0B1L+znGh5j0d9Nu9+MxyfOlMZg=;
        b=eN+UZ2+Yy2+iCmuH1XNaFcLUkjnPratLXYjroflphDPnOajOxBRwbWt6aKibBnYPTP
         bqkonGN6BkcXJyeXcqK6xt3BNXUb4DDOarQooODu/w1Kn/gxaHW/Ll8rk/8Vd4mOQWYt
         mhmZwUJtnLH6+uh2zpGyPraHE2J/bvzso9TppVu1+8/mLLB2YkoQsek8nDcbQzEcgz1x
         8rMxcb3RSzSWoC4JxY1YWz4jXzEi7j5FLA7+Lt3kSTngWXkSPO7o4thap7dp3B7B2jQ3
         yT/7uDMLxhJ21VR9hIe1WBnUrib4YLAGiXDql2dBlPss1yoNgRtqKMpUji1h2aMCw9du
         iEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552366; x=1703157166;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkUIKGfxi4N39L2w0B1L+znGh5j0d9Nu9+MxyfOlMZg=;
        b=v46IUGgCxPGP26JT2NlNqR2Xkd+sFw4bI6zRa1MukdErq2SAPfuJ2MDVJMbzTU9Xbe
         FDhR6C/59MTqUxUMrlpsy9gRJNJ2dbwLoYY9cGR7BG45ISce6bdR4pz+TeM14CF6c5PC
         SWF/+4WNYuD+qyE1RiJiyNB1BhoZxOnenrtXa9kp/Pb7BzwGMFA7qrIKc3Ye2OEYPvzt
         gWIX6797/ZVXpsIn6WPJQgL1hDkRVmruTNfxXWlf1js7RMgmComVl/e4vGwipUYsbgYA
         uYTa5RRxVeHBdGZpbIpwsZjrWZeK9fICva6COHfmxLci+bNK1ezXa6vMxDKNQLEWeNFe
         /kzg==
X-Gm-Message-State: AOJu0Yyv5r+5CoSHMmzVaP2qPwFqsolU/2/ZgWDm1byh+EoYSjONrZ/B
	W77GeLjPPFSV3Mhx/Ka3vBU=
X-Google-Smtp-Source: AGHT+IFqm3CUq95veeUXjNvPRRh/z/t1KME7to+9zTXAOFJuBlOhxM7G0GssppSk/lSjlQSrgFMYhg==
X-Received: by 2002:a05:600c:46c7:b0:40c:5971:6162 with SMTP id q7-20020a05600c46c700b0040c59716162mr1765318wmo.81.1702552365833;
        Thu, 14 Dec 2023 03:12:45 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b0040b4c59f133sm24228826wmo.1.2023.12.14.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:45 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 7/8] tools: ynl-gen: store recursive nests by a
 pointer
In-Reply-To: <20231213231432.2944749-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:31 -0800")
Date: Thu, 14 Dec 2023 11:11:57 +0000
Message-ID: <m2plz93uo2.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> To avoid infinite nesting store recursive structs by pointer.
> If recursive struct is placed in the op directly - the first
> instance can be stored by value. That makes the code much
> less of a pain for majority of practical uses.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

