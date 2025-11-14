Return-Path: <netdev+bounces-238673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC0C5D486
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1F3A4E34CB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9F243964;
	Fri, 14 Nov 2025 13:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4175809
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125664; cv=none; b=WU41D6dQ1Jnuhyq1bj6Sk7sFRXa401Mqh3Yp/gLLwa2eoPddwSkZanF9b43auGD5udh6hb5dkC8+K1sUrFD451NJZWeYicyo5OcXx8UGXFg0t21wi1kjhUZwX4ENCeGUuLZQ6YoOfvOwPfrWH8aOIDYD6LtcErtf17Aj0IYSfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125664; c=relaxed/simple;
	bh=XpRgNctZogZPOyMTctanQfbuia14WJM14QLnFQBVIwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmtD4i1Ty8hoY1mY8zwOSsO27nZmYkddvpe4JePqGOqqGWprbIOsp8XHC0zlQdFFduK3oc+qV+KaE7kAyCHxyJRkvvJpn8R1sRgezim2alRPbAocYivFF5aPly8jA1ZN6BGTGljaSclDk65lQxCoWmezD3c9DtKeNHlPSreZ7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-44ffed84cccso329240b6e.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 05:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125662; x=1763730462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scS56hyiFjjliv29GEv9MnQOfltcbJ+rafC8RSzG4ko=;
        b=FOEvMsEyKlF6CTU/u1CugO9E38zI3jPl2uCPdJzFFh2WIM8Ww5Evz0VN01s4DuLlN6
         fL8lNtiRJFsdKF9XSlEaDiBY8MWTglPneSewNWLQ38X+cMA7DU+B+K3m5LAxt3H0D4fK
         28rOk2dCm7SACOoor8uBgBVoXnHo30TDX756nt7/fBeK9RfG75PzHCvnd0z2V8I7V8N+
         61HPT+YrhngCizVFFfK0W7ferkEAGqffao1+sWBDPaF9twOcALX6iiPtDEWupU1rmK1V
         LVIsV0w+5Ewphk+mpTXPR+MchbVl3zhMdFgcT/8TogYB9OmbU2QuZjD2FspoFJy00g6B
         pP0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXhp3WhR5xn2XHpZ8HJB+VBVpjblettTU4rBPrfuymV7HJkyr5DU6XjvNt5x6O9uCANU5+b7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBW4XE8b2hNXZhXldrgnORTRQbU3lHaGLg/Hg+yWOZC0u4ebiz
	pOrH0mIz6AU+jmB0ChwUlRKsteplycbwRKNNmhpsF4sxhBkwOd9apfFW
X-Gm-Gg: ASbGncs4Xe1zJRi2eKjxMGhhXR7R8Kevlj7xNoWpqMfTXZfllBD9tlj5Mk4JmAlnFzx
	cR1beuuVUQlfAIPOK2BhKXJm4hB3t8rr29AafHSePiPaydVG/xiGJ+Axu3UByIHUpcKgitZVPeI
	HpMw5LIaDDA2Z2x2hnu4cMLUkpq2Vq3f6jZe5gUCregUihcrWqHlih+6XHVcItbTrwXy5Xznyex
	HqDRI29FeT7L8gMqTLupMyDuGvhML3t+U1XIzd7GcJJ1PrWyYXPGwGsWXk0r6U7qa79XCgIfAtb
	4Ea5Qn8QATjXN8QSNFWp35noCrUxhAxv2ClzIia07teXZsIU+ttmUqvSC1HV3dOUfiApTV/WZo/
	Hqs5flGeUcNtEtffaipSQkhuS7RXgvF0adaHN5EKjTLEG+pX6VI8dSfaGlQKqfJWzQZ55jFvrkP
	yQuH91iGzddihG
X-Google-Smtp-Source: AGHT+IFLGoBhM6cR+vHZSkMlkU1qmRI32euUR4PJIhFxbKjDVZay/th8eiP1k9kjIaBNsTgHuOmBQQ==
X-Received: by 2002:a05:6808:1508:b0:450:9f5:dcbb with SMTP id 5614622812f47-450973f9bb8mr1304172b6e.22.1763125661654;
        Fri, 14 Nov 2025 05:07:41 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4508a6d7b24sm1967935b6e.21.2025.11.14.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:07:41 -0800 (PST)
Date: Fri, 14 Nov 2025 05:07:39 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Message-ID: <v4xuuka7oovpcmcw4ualj5mdhw6jlgtcdheybbwtuy7qhd6nyd@3kav6dwkkdac>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:21AM -0800, Gustavo Luiz Duarte wrote:
> Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
> buffer is allocated dynamically.
> 
> The previous limit of 16 was necessary because the buffer was statically
> allocated for all targets. With dynamic allocation, we can support more
> entries without wasting memory on targets that don't use userdata.
> 
> This allows users to attach more metadata to their netconsole messages,
> which is useful for complex debugging and logging scenarios.
> 
> Also update the testcase accordingly.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Please expand netcons_fragmented_msg.sh selftest to have ~100 userdata,
so, we can exercise this code in NIPA.

Thanks for all this patchset and improving netconsole!
--breno

