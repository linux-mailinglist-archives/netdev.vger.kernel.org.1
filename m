Return-Path: <netdev+bounces-205443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F7AFEBAE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7299E565545
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2C62E92DA;
	Wed,  9 Jul 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWAUgoEq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CF2E8DFE;
	Wed,  9 Jul 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070057; cv=none; b=PsEimlzD1Sp+D65zYyh5ZH/QXHw3cjbHX3ldz35EJTSvZzf13j2VUbSKMF57QvmloHGa4YSvhibnmbzK5yz/oCFW6d1FktAzJzVxQ1Z18xcT0AFQd40+F3DaiDukGUA6Aae19GfrpamNoxvSgT0UY12sMcu5CTEuOJ9yo3Aoj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070057; c=relaxed/simple;
	bh=Hm0bvF4DG4aG9LPmmsB2p15ILEZrzXfJImhqafJXnvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NxQ8yoNnHC+lNFr/+iicWk0iFPY1cK8p07GmLHPjU+WtabTLK9DvMn7P5v/WSvb73MGtnplO3Flivf61GXENk6MgtzHPK1oYUvBToLYb4djpSDHFs3tW9cCnakdiwwDF3crGZvyVCLKt6aqvOAGEtuD0j/gkYk3+/JKoMcodN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWAUgoEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58832C4CEEF;
	Wed,  9 Jul 2025 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752070057;
	bh=Hm0bvF4DG4aG9LPmmsB2p15ILEZrzXfJImhqafJXnvY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iWAUgoEqjEQTQxZ36FcfbNFyFBVPNRA0D0JV+LccBOTVsCmu7JPvn/T8KCAllMK3m
	 yxju8s4XhSpqboQ/ABUZU+sab5Sb9ZxwKjOPw0rMfPYjtgjoZYqhGJD7h7xPmOCk9F
	 Q1eYDiHJ2Ck79lP1kalRvdLJAKjet2cN6wCrPYIG/feNTDBTuE9gBM7vk5Cl2+1ozD
	 RSTRZGDDzDNMvJQdq++DOftuR0Ogn7QN5mmLbialUbGcKiRkAlsaVr66mYquIiKFAi
	 pwcJA55gOMdV0+k/FI3k35OSsx2Vja23RzsrNV4BcLKC0bvdRt1UliBpANh/pnyf5I
	 oTE0RvvJbcFzg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 16:07:30 +0200
Message-Id: <DB7KZXKOP5F0.1RMMCBJNR43KO@kernel.org>
Subject: Re: [PATCH] drm: rust: rename Device::as_ref() to
 Device::from_raw()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Thomas Gleixner" <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709-device-as-ref-v1-1-ebf7059ffa9c@google.com>
In-Reply-To: <20250709-device-as-ref-v1-1-ebf7059ffa9c@google.com>

On Wed Jul 9, 2025 at 3:53 PM CEST, Alice Ryhl wrote:
> The prefix as_* should not be used for a constructor. Constructors
> usually use the prefix from_* instead.
>
> Some prior art in the stdlib: Box::from_raw, CString::from_raw,
> Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.
>
> There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
> fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
> SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.
>
> Link: https://lore.kernel.org/r/aCZYcs6Aj-cz81qs@pollux

I think the link you actually wanted to refer to is probably [1]. :)

[1] https://lore.kernel.org/all/aCd8D5IA0RXZvtcv@pollux/

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Can you please split this patch up in one for the DRM renames, i.e. drm::De=
vice,
gem::Object and drm::File, and one for device::Device?

