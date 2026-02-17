Return-Path: <netdev+bounces-259038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLd7BTNzlGkMEAIAu9opvQ
	(envelope-from <netdev+bounces-259038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:54:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28914CCC5
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C32A300682E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591E36C0A7;
	Tue, 17 Feb 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNytYOpU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1236BCC4;
	Tue, 17 Feb 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336476; cv=none; b=p/1/+QoXbrPlFClNzCAqcwTeCNzhxiYLMcsgDRkm/2pxgbaXNWJZMERApFDA/chvPV5K2A9ibzQK9FJHXaqgv+qX4dAsS010IDEyTWcZCR8T/bERC6j2Un91dVcNPGy3nlT7PUOXBaVtr/RiMdlPkZQ4vC6pv725YMSlDUC7oOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336476; c=relaxed/simple;
	bh=B0kQDe2OjE89c7bJ4mHgExipwiqbMRAUVjBXVo37mn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl2Fjo8zGWWoylXhCaQixergUX+ngUKAMbMsczpAOrk5GKecU+NZkRG2vjiDLc5sEDFvAOykgsCmtGLPFSR7gVAq4tx94A58c4DYFhVtaMKjdxncWUZzz450B+MPD7dbai66bp36CIdSaoeDZTbWxw88VjuyIT9hLiQDcCcl95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNytYOpU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771336475; x=1802872475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0kQDe2OjE89c7bJ4mHgExipwiqbMRAUVjBXVo37mn8=;
  b=lNytYOpUHuZnN2D9jWEbqJs48y95an5OwwoSToeHfTv3BaGrXEaqMuIo
   Ku9fCNA4VjUJqRc7glsZEh0RBpxtuvPEMACSTrW3S7+CTGKBpi86oZtUG
   ND+RFyye1UWLChtrGbsnGdLF9h741yB2x4STYBnxbaBjtVvvpOIowBcfn
   FBVxOVCyMZc4PotQc/Oe+vN7kNUBo0vGS6T/4kiSRhV321KvwVTGV1p36
   +xH+KlCkf2MTjeJEyZyofrRTlLxRUPb/CQCrldiBt1mYoINmUXNU7Tlzk
   7KKMYlAAH0y5F5dHrlzLSen77VkR9QtFLRkc8C+bHtS/60Xc63V5goWG+
   w==;
X-CSE-ConnectionGUID: XxKUWZ8tQYqDEwo4W4PK9A==
X-CSE-MsgGUID: IGlv3Y4VS6GCcKVO5PVCdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72292073"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72292073"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:54:35 -0800
X-CSE-ConnectionGUID: M0/7lVR3SV2gfOG2J3/CCQ==
X-CSE-MsgGUID: 5NsUMfFXQ9O3eOF8hloHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="218421147"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 17 Feb 2026 05:54:27 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D88E328794;
	Tue, 17 Feb 2026 13:54:23 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH bpf v3 1/9] xdp: use modulo operation to calculate XDP frag tailroom
Date: Tue, 17 Feb 2026 14:24:39 +0100
Message-ID: <20260217132450.1936200-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217132450.1936200-1-larysa.zaremba@intel.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-259038-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D28914CCC5
X-Rspamd-Action: no action

The current formula for calculating XDP tailroom in mbuf packets works only
if each frag has its own page (if rxq->frag_size is PAGE_SIZE), this
defeats the purpose of the parameter overall and without any indication
leads to negative calculated tailroom on at least half of frags, if shared
pages are used.

There are not many drivers that set rxq->frag_size. Among them:
* i40e and enetc always split page uniformly between frags, use shared
  pages
* ice uses page_pool frags via libeth, those are power-of-2 and uniformly
  distributed across page
* idpf has variable frag_size with XDP on, so current API is not applicable
* mlx5, mtk and mvneta use PAGE_SIZE or 0 as frag_size for page_pool

As for AF_XDP ZC, only ice, i40e and idpf declare frag_size for it. Modulo
operation yields good results for aligned chunks, they are all power-of-2,
between 2K and PAGE_SIZE. Formula without modulo fails when chunk_size is
2K. Buffers in unaligned mode are not distributed uniformly, so modulo
operation would not work.

To accommodate unaligned buffers, we could define frag_size as
data + tailroom, and hence do not subtract offset when calculating
tailroom, but this would necessitate more changes in the drivers.

Define rxq->frag_size as an even portion of a page that fully belongs to a
single frag. When calculating tailroom, locate the data start within such
portion by performing a modulo operation on page offset.

Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba019ded773d..5f5489665c58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4156,7 +4156,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
 		return -EOPNOTSUPP;
 
-	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
+	tailroom = rxq->frag_size - skb_frag_size(frag) -
+		   skb_frag_off(frag) % rxq->frag_size;
 	if (unlikely(offset > tailroom))
 		return -EINVAL;
 
-- 
2.52.0


