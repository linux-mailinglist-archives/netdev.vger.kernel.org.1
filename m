Return-Path: <netdev+bounces-63549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5EC82DDD9
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C9CB216BF
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445917C72;
	Mon, 15 Jan 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="jiwbEYJE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnedzDjS"
X-Original-To: netdev@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0317BCE
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id D0595580143;
	Mon, 15 Jan 2024 11:46:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Jan 2024 11:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705337176; x=
	1705340776; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=j
	iwbEYJE+2naBgOhrHPE4NdrjapZYvwi/hW3xiNV21FOZZO8sFn5w8AHPxzzmRWFz
	IikkAVOEiW7qKHyKf1E3MzVbRWqz5GiN79ImR7s3fBuIvfvh5/JPbSHy1PSDlihI
	w8E6kJOsYD1VSpQjkF6TY5eOQSZbexttAVSHhawGoH7oGZpJ4J2s4u8MMonnzypq
	R9TkeHL/fdRaSbauI+jlJOr6byGdSPqvPqnEYN0xKb+Jyd1nZfty1FKt/Aegoh4U
	JP0BMlUTacgvEQkq89T6zS11S0TgjwxN6PlgkFj1jXCxIAvT2vQJ/bPgyj5QauVQ
	32/P4wCfCDW6omgEZ0mEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i14194934.fm3; t=
	1705337176; x=1705340776; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1
	fyPI6Bx0=; b=OnedzDjSd9JDx4JqjBrZQT6VW2vRZc1Tt/FbgO90l7QZ0UYbmG4
	KoQFOasBFhcqqgDG5L2A8V/eeqU1Ml53ZxMTS1cvJI5AgCMuyB1FAPrKCLO2ZTs2
	yYGjstQB2rW44cgMRo2NjuJmFQXJEYowc/LMlYm+7lA1B4WCPNxiz9tRVHyIZoO6
	VCPtGZTXCHwXupNaK1rBEEjBhMHxBKrNFu2CyPdS8s2rgjYAgk1e2dxsV3R2GaLH
	10D7p64xLCAWH/Dwgo+DkRNwm8BitneGxh5GwhGoixkjrDtf6tDZWYTUWktEDl9H
	uD4kGUAsxHkn5jgn1h5loLRKLJC/P/9BTFQ==
X-ME-Sender: <xms:WGGlZbcs7D5243uaVK0aFourMcOf8eHwjn9gjD3Dyr22LaFeyYDwJg>
    <xme:WGGlZROQZS2tVdSAJK4gh7SJJlsWHiGzVPAKDE_h0MPjacdsaCj_K6pumR4b0LxdL
    Jcm8NdpgCdlKT6k0MM>
X-ME-Received: <xmr:WGGlZUjCk9ZFMC1RsiA0wYrGnlQ6nPftJtWAGcb6-3e_XseL3yWsdiPT3GyDblDMu9Z-xrmmPdCR9J0-4aC7LNgBM1C7OLxJNnygsuV-Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepveeiheejtdevveeuueejtdevhedtudfgueekfeeftedttddttdelheduheef
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqh
    guvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:WGGlZc_Uuewqd7kRHtkxdVzVjDIUQTOuLulMvF0sQDZo26t0pZCLpQ>
    <xmx:WGGlZXtaaa3OhY2fXQtYr7Eb3OBQ2eJhG8jqx_jzeDGOg-D8jA5r-g>
    <xmx:WGGlZbGkcBG8Y8QRw8rhMT70aN6XGFcLznfzMJzfEuk_HeO9a_EvIQ>
    <xmx:WGGlZXKPDNiN6slDnJzoVowBlf2ifu4G7ZSpMuzxLa54X4g-KEorOg>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 11:46:15 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v5 3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
Date: Mon, 15 Jan 2024 17:46:05 +0100
Message-ID: <20240115164605.377690-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115164605.377690-1-qde@naccy.de>
References: <20240115164605.377690-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new --bpf-maps and --bpf-map-id= options.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 man/man8/ss.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 4ece41fa..0ab212d0 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -423,6 +423,12 @@ to FILE after applying filters. If FILE is - stdout is used.
 Read filter information from FILE.  Each line of FILE is interpreted
 like single command line option. If FILE is - stdin is used.
 .TP
+.B \-\-bpf-maps
+Pretty-print all the BPF socket-local data entries for each socket.
+.TP
+.B \-\-bpf-map-id=MAP_ID
+Pretty-print the BPF socket-local data entries for the requested map ID. Can be used more than once.
+.TP
 .B FILTER := [ state STATE-FILTER ] [ EXPRESSION ]
 Please take a look at the official documentation for details regarding filters.
 
-- 
2.43.0


