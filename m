Return-Path: <netdev+bounces-46874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2007E6E07
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5291C20A05
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773A208A0;
	Thu,  9 Nov 2023 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="GFXwFCV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cn2nEjRA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29B208B8
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:49:42 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA152126;
	Thu,  9 Nov 2023 07:49:41 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 65F775C0588;
	Thu,  9 Nov 2023 10:49:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 09 Nov 2023 10:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699544979; x=
	1699631379; bh=F/IWwTw28WQvamBg7CHtgk6Ra/BSw/1EiGUVcysjQ+s=; b=G
	FXwFCV7l+WqAhBO22/5VSpVHyiHXOQ5EquvUQ1oVdAgW2vNmdbwTuOmd1D/vzgor
	HvRLA+czieswnWKY9KpKjIw66dFGsHc25a8VEPFVvYyqh/x3ZgvXPCWi7nqQ6/Ja
	t6txZ3uFJOOnOLT1ZiRAkECz/qhStHkm9E8TCEZ/OY/z3W/Ge7NupCcBCwq0r0VU
	qecj5MeDLREoebdW68prqaFCv3omRpVZ6yiKveQ0yiJR2mEYM3AtQpY3DjnHKdq8
	vhCKbNVvTtk998PQTi9f5kyHvuBsuvlzE3ih4YKAOfrlK1wcDiDKcbhY3OPPCP2z
	uFIMBGbqlIb4qINs91QRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699544979; x=1699631379; bh=F/IWwTw28WQva
	mBg7CHtgk6Ra/BSw/1EiGUVcysjQ+s=; b=Cn2nEjRAEQdB2iu/c54zbMmyZDQM8
	/W1/GSY7GeeWNJSX2sXyRxXY+DKA07hVdCsKKs6QDxNRNqDT52b0JQZxSZUh7QMq
	ohI1LpDc08Bkj+GN4IjKoNHNkKD++2kp/1D8+4rj7BOnTROeApDUEarh90BiUq6J
	xfIvM9yq+TTSraftRUjiBS+Wgq7Uj4RNtONJBOevPDXHAsodQo/XLacAQzqH+gKv
	Yi2ruIMCPw/PkTCrGT63tApOZWLjGZ1q11PuOPLXuqbDHIFM52xS9OrCcu8dEVUi
	5pTitoqaneQbhTxvYw4Zpg2btCBdY3fjTu1yb9b5dj82jD8sJyi15fCVg==
X-ME-Sender: <xms:kv9MZYq1_5lJbnEEvHD9UCyIAtTxqg3UtNUe8EonT2nnl9OK-aRNlA>
    <xme:kv9MZepjKJ7hcwowJpBpZrygKBuh9TkmgrnIf9B96gychZdf_ROIEqNjTylQSKnsp
    VRKkq5OWY0cL0ZWm1o>
X-ME-Received: <xmr:kv9MZdMeD6AHDjx52aLFH2_YIFUrQ7rRwrOmT1osHM92cBcHEjBrVom_pt6BwfwiKwof-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:kv9MZf4diWW5fjmGKgbqY7mAw6oIxKbxrR_2MGscgjuALmsFRI-2hA>
    <xmx:kv9MZX69v5LxveInGZSznvnsDiXM0ALzeeeZ61KzMQN9G3QHp2V-xw>
    <xmx:kv9MZfh-8TSIkaH4NtENZbmVMFfQQ0t6Y0cBdgN_pgapkxawuQmSPw>
    <xmx:k_9MZUuRTcdgyRWwzZLxChKQ5nGK-TF45MxPUm6iFZRoeKZyTP6ikA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 10:49:38 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
	id F22B210A31E; Thu,  9 Nov 2023 18:49:34 +0300 (+03)
Date: Thu, 9 Nov 2023 18:49:34 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jakub Kicinski <kuba@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [GIT PULL v2] Networking for 6.7
Message-ID: <20231109154934.4saimljtqx625l3v@box.shutemov.name>
References: <20231028011741.2400327-1-kuba@kernel.org>
 <20231031210948.2651866-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031210948.2651866-1-kuba@kernel.org>

On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
>       bpf: Add support for non-fix-size percpu mem allocation

Recent changes in BPF increased per-CPU memory consumption a lot.

On virtual machine with 288 CPUs, per-CPU consumtion increased from 111 MB
to 969 MB, or 8.7x.

I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
non-fix-size percpu mem allocation"), which part of the pull request.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

