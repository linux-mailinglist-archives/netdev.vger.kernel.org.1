Return-Path: <netdev+bounces-292988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOGxIsgmGWq9rAgAu9opvQ
	(envelope-from <netdev+bounces-292988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E36EB5FD6E9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3811D3026F32
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EB39F184;
	Fri, 29 May 2026 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TcZBuL7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F917745;
	Fri, 29 May 2026 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033187; cv=none; b=QbSaJxhjaoYkM7M3/SQY009l2p9UpGYbPy5y98wKa6Vns1o79Nszh4z+BF+Vfd89oZKAyClWSsQyphYLsUVAklr22jcNrR4uRiDDvkeMfGA5H1sdTZ0UwDIZVkPHkXQddlo6w0L/hp3G6AwbPtV67RwaCzhFqKZWb96EWCPRdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033187; c=relaxed/simple;
	bh=nO7ogHAKHn9ZRHrqPAt94m4xCkeDU6Fnox760kViPTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niCckz3Bw2RTTprhXYT9IEA4b2pkGEtOBXKRA+wIOBHylKUbmQh2uVaTqfj2pKpT4XZhtIQB6GhT5RhwiPHZ7j+5pV7v/gcGBj2/D86xneOBnRiEnBqEFuaphCksSvyWfgxQ0eB4ghp1Y1DJfTJKr0knL3h29H5/QMBo6j7ZBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TcZBuL7d; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780033076;
	bh=w1ONFpfIdPAWMceFFrpPiIqatePtthElUP6Et+fSb8M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TcZBuL7dMqEXjm0IZB6WsHxjaGZCe3YgisOHFJjUYB4qVwlXhCIzraBGf8JibHJvt
	 MmS2NH3vy9KiApM/CR6xv8QyQN/+L4LNXq0Gm6JhqF02gKRoXpxkTwIebaUcmAANNJ
	 FrBcwe0iEIbrEF6RiEyjVsaSjZ3MKwBEhAFiBvL4=
X-QQ-mid: zesmtpsz5t1780033066t39dd5d5b
X-QQ-Originating-IP: 2Rf3q/fdA1E7d+O7Srod5LXOW0idSnL6+dciArsfJPg=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 13:37:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5534762632318884595
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ice: dpll: fix memory leak in ice_dpll_init_info error paths 
Date: Fri, 29 May 2026 13:37:31 +0800
Message-Id: <20260529053733.764996-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260528171202.2659491-3-horms@kernel.org>
References: <20260528171202.2659491-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NAeO0+xU6W76l6nBX0RxNcnzlyTcEqN/jnKr4LhxGFe8D8Qzb68UGPpC
	1buF4f3PE8ScC9tbVC/wMB+yDLzRgpeNGbirPJE+yjysYajJM9PvtDhCP0pEQwcNMEmRvmO
	ENSKivMeasBg7lGwcPQIVHtfdgJya1IInaPWLLvrLs7o2CoBfO5UuQBAzKRKqxCPJKxFlx+
	rwVy4ur3x5th/6tH9vaF+kDrNB6sOvfkTi8Y0suhufFXlN5GyPtTVdVPpRk4MCCzsXZQ8lM
	rLX8rbK+UWLw7ikErnyHT7Xag0KJAHj3cAN/3oso59cBoUgWRDEE+/33fUsanjYZpwPE+R/
	sKVZApyEoOJEvYKCOkxv7Zxui4OD8/30MxTAyequxbh8+j8J623LSPk5sr3QfwItpB40pkY
	6jr3ZUbaDBVEgQG8QZu6wnz0hd2tuXCtWVJCAE8O2B8e10m+5BWiCR1l+idxJ83JWyMDAze
	BU5LZXsXLKliLUIvQfIncbZUMGhclXODajLDMx4VQtF1bHtyahfF0/8zmul1G/1/sRNg3Fc
	e9ucw6PZYVJmlk210lDgvvjitPE9qrHA2zCYVqU4/P/jPsLyZ46YEvJnoKGiDasxUtTOxvd
	QkJqy1Jue3kA0EPionl2vtd4Mrku92gJCZWTBi7TDhLa7k96MWcMreHy2eIdrAKVyjcRe0/
	1sPdXUkLjnMTHOenRu9VrXXY1Hf7H33SKzdVZ6R9jFMQpzylr0VvE951lgE20ckiS2vp58f
	Y5pKf3A4lrHBkGMerhrNeD3pa7k2AhvK3g3PSg3FnuHn7TnCIrHiNJL6z5yfGxLm3xpsOn2
	WggxrTcgydtrFw4uk1duftxBKwNLwN12MNtOjdveKXe4S4Mv+KXt89CNoqvNfIDgvqtPRwd
	0NCVtqaD5E2DAIHobUTsq/7QZs2Uit87nmx22MVuKaAHX7xjIx6L8BqbJTrwzFNIXoJCcpr
	afVdAzqrNX0cnntruxQB+cBfunGMtMnNNpyqGQ15E8mPCzgMhKt+McXs8rWezgS1PZwnKr7
	0EuzIWvBtETlmZS38W4MFOB4KY2mc=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292988-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: E36EB5FD6E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a prerequisite patch that sets the pointer to NULL after calling kfree in the 
function, eliminating a potential risk.
Update to v2 version of the patch.



