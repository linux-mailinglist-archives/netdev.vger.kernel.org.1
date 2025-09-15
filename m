Return-Path: <netdev+bounces-223002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679DB57750
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1D4161BBB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69042FC011;
	Mon, 15 Sep 2025 10:58:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0742ED846
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933880; cv=none; b=KKPWglNF5aFKTY0NotjSg7xl3i9R363R11f2EULyo3iYiB4Nqrlqih1biiV//SdvDHdT2JsbbigwGZbe37J5lVrlNTaOqJe7pBOzJBLhT6tL+j0HCsmfHUVVdmwsgE8/UkyqLuEWsuota+nEU0/8iJWtnGwqBbqkKenlB83sqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933880; c=relaxed/simple;
	bh=H8a9AOknFnKTAIvE/ikaP5nTBBNK9uvX6MCcpkX9++g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu643ebP/op6h2BUCNBd0q4p9kFsXEOSi7c65VKJ1tzE6bg3did4QepcjD5TIoj1mpCESH6C8LzZj07WIMlKBugnwr2wwIknt6Ti/qG7UkW5il2NGUBUCOSgnod90zM8hG8cojPwb63BIG9I9NDVD5eylwevihn2mjeQM0ueFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so1301206f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933877; x=1758538677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxA92b/5xfR0qSfNO+nVmulxGyOD0T7zyHwVnXVrHGY=;
        b=U7j7V7IUdRK2YUS1ZOBNkE5/f4K7Coz57etiQ4Wif72jM+5OW6GLjlh5svcx3pYZO+
         bQQIW6+eaI/T+HCZ2t4rIwSI1y11HCkFU06PySq0s352Fx3iubPSkQ8XxTDvieTJuGGg
         j9Nxu/Z+/jIWOQW0IiCG9F1ztulhck0X89nmnFjRSql3o5Tg9yM1y1LmeKMt8AqOs7Ct
         ZqdVGXkB5Tf1MP+kkZG9Yp99VOfnbMwQFPwFZh4AGAeqFxB8Q8k2fqXLLosB2RVbBiHD
         V5O1m13ToI5nOEciCTSVqAaEFplHpPVTlBar+Y06nwGA/+j2nZiM35j6qdf/bUrVIecx
         Tr5w==
X-Forwarded-Encrypted: i=1; AJvYcCUJnastO48pNDHBMJIuuW8s3sFlqGRYtp3T/3DTNiFlknYWmq3b5vVPAKUH7ATcBNmyLLHQzOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpA9UXOhfyGOEejVQUxO+0C9SpvI7s4QO5iAD6zMVPDJMhxDL9
	636evM6WtedDyHj3d1r/XW1oOxfaeIwDdo7e0TQhYZrAh07d2pWrQHjd
X-Gm-Gg: ASbGncvGcHZcNZL7nbK3mL/SiHfrXFiNCPWlxpik3wxpiGKp/z6cQi93cyWM3ZLn1Va
	AX5Qu7++aTQQNtsTv4N6uGvVsTuIT9XwgznsA6mv9bUgJTqImKmVWzmcKE/Lar8NgL88NtcFCez
	Z0RYFUQER4zHGnxKUMilU97SVDScmw3YfEMLOgpTlkBjwgpXoUtffWkv10dho+ATdUmZ5KuhBOV
	v+3LxFSUZZLViyyJ2C+BWusLlYnOL5uxyeZmn2tmZIXHTA+GdHcMOvD6+5rr8o6F3+1RKG9lnh3
	zLFbKjxE/bRcpZVGYdmzzX99f2ZCe9b186tPxB9J+qi5cUOFi2aWfgbq9yZZJK4TATLB1fy5pFR
	pn3mE1+wALl5c
X-Google-Smtp-Source: AGHT+IEqBROGBlCJuMZ5Xroh5nM+yePitTdtSR2h9RagADSGmVIoyFS5fOwROqRLNyP0ZkUbkvwstg==
X-Received: by 2002:a5d:5f42:0:b0:3e8:6b2b:25e0 with SMTP id ffacd0b85a97d-3e86b2b278bmr6162260f8f.25.1757933877209;
        Mon, 15 Sep 2025 03:57:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm8998142a12.18.2025.09.15.03.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:57:56 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:57:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
 <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>

On Mon, Sep 15, 2025 at 03:55:53AM -0700, Breno Leitao wrote:
> On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> > This series of patches introduced a kernel panic bug. The tests are
> > based on the linux-next commit [1]. I tried it a few times and found
> > that if I didn't apply the current patch, the issue wouldn't be
> > triggered. After applying the current patch, the probability of
> > triggering the issue was 3/3.
> > 
> > Reproduced steps:
> > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > 2. applied this series of patches
> > 3. compile and install
> > 4. reboot server(A kernel panic occurs at this step)
> 
> Thanks for the report. Let me try to reproduce it on my side.
> 
> Is this a physical machine, or, are you using a VM with the virtio change?

Also, I've just sent v3 earlier today, let me know if you have chance to
test it as well, given it fixes the issue raised by Jakub in [1]

Link: https://lore.kernel.org/all/20250914125949.17ea0ade@kernel.org/ [1]

