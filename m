Return-Path: <netdev+bounces-59920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57181CADC
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008B9B22063
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13765199A4;
	Fri, 22 Dec 2023 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZBYzOIv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3F19465
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2335d81693so336900966b.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703252806; x=1703857606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOK6D504CLxxdHQASJ1VcjUbwJSzejSUsInCLwhpoRo=;
        b=WZBYzOIvLgaSCFvtIETLgpwq0hk0y4WAsF/HPWmE/2qzqmtWWTzZI5GklpILRZPGHH
         k7Z1Pj9Kex95NagQJ0zHgxreBnxgczisSobluuqwOZWKZ9lrc+HAwNRsYj8IqPrhXzvJ
         KZ4EeGaiKN50znxXvQwFVSodpBoq8NPOy4BrDcA6m3KDdPf9B4Id46tbK3Xb9T+W7VHT
         M/kV9q298pPvKNmlPu6jy76lI1bjELoTNoBGsfU91P+ylXsRR2dIhrHua5A5YLw9wMDc
         ibfk8hyjirIMf9LpKsNsJs8ZN75El+dAQXUbKHsgJVBp5dW+r8Et+ShfkDsRNsz7SGat
         Lx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703252806; x=1703857606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOK6D504CLxxdHQASJ1VcjUbwJSzejSUsInCLwhpoRo=;
        b=LVDFePLLJO0c9ts/q5Y6sxQyUNGFLT/YPC8X7mWpbQt25Cns+xzagyOSgZ7qraMY56
         WPgT27I6vmUfAH24R9Z1BoGB24XxCBKKbnM7K0PhpNjxJqHkIRRjlvUGExwDS2SM/jzT
         NPP/u2AI1UfD7Fzut3xdJJStLVmnm0F2AOLLPGLpLQ32WU4fMqdauF6859XsBHdsyad1
         5N1hGQmjywDCyi4iExoZrw/ToanLv8XaAizM0j8AXl8zIvjZWQC2BVFU+YcupNigbWcp
         /LVXqQ3JzLBzNkeuYEhfAX570xw+iH+6jzbdJkHeGpj/yqKoLLe1HOr8/cABel9nKoTG
         JoDQ==
X-Gm-Message-State: AOJu0YwYQNnQdbapy18m66fMRp4NXF0M6k+sSUTIIxV2MDX95scKVbS/
	jGW8q1l4YbwRCv0f9VlGmrA=
X-Google-Smtp-Source: AGHT+IHpGwliTuOmKdzZmqiC/pmk0MykrWoYkUFYiUXU7Q5g5tSTsl17ntCzLp3eQVTtMPr2eTDZ6w==
X-Received: by 2002:a17:907:91ce:b0:a23:8a32:466e with SMTP id h14-20020a17090791ce00b00a238a32466emr1572653ejz.0.1703252805816;
        Fri, 22 Dec 2023 05:46:45 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ez11-20020a056402450b00b005532f5abaedsm2589708edb.72.2023.12.22.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:46:45 -0800 (PST)
Date: Fri, 22 Dec 2023 15:46:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lucas Pereira <lucasvp@gmail.com>
Cc: Household Cang <canghousehold@aol.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
Message-ID: <20231222134643.undeg7ruu6ptqisq@skbuf>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com>
 <20231222123023.voxoxfcckxsz2vce@skbuf>
 <CAG7fG-bDdtTxWkv8690+LHE5DVMKUn_+pQGsFVHxjXYPrLnN_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG7fG-bDdtTxWkv8690+LHE5DVMKUn_+pQGsFVHxjXYPrLnN_w@mail.gmail.com>

On Fri, Dec 22, 2023 at 10:22:21AM -0300, Lucas Pereira wrote:
> Dear community collaborators,
> 
> First of all, I would like to thank you for the prompt response and
> the suggestions provided.
> 
> We conducted the tests as indicated, but unfortunately, the problem
> persists. It seems to me that if it were a Checksum-related issue, the
> behavior would be different, as the VPN and communication work
> normally for several days before failing suddenly.
> 
> We have observed that the only effective ways to reestablish
> communication, so far, are through a system reboot or by changing the
> authentication cipher, such as switching from MD5 to SHA1.
> Interestingly, when switching back to the MD5 cipher, the
> communication fails to function again.
> 
> I am immensely grateful for the help received so far and would greatly
> appreciate any further suggestions or recommendations that you might
> offer to resolve this challenge.
> 
> Sincerely,
> Lucas

Are you responding to the right thread? This is about on-board Ethernet
switch chips attached to Synopsys MAC hardware IPs.

