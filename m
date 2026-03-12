Return-Path: <netdev+bounces-267161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN03DcDrsmnAQwAAu9opvQ
	(envelope-from <netdev+bounces-267161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A519275B48
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C0843014A0A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BBA38D00A;
	Thu, 12 Mar 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hp0yl9dN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EA2DEA86;
	Thu, 12 Mar 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333199; cv=none; b=qmNu66/GlPBWnnYp/kXKHHdW1f/xyTfFBp8Lx/naLDXvSywbJmHUO3OQ0/RQv/dM6vRcLrSbAUHHcZ2xc9KQ3iImJCtL6vPi7CxvNp4aYy8z6/iLmQK8rmwxXn3Xl1xOva0werzVm4rpC1bP7s34JVtE8/I6O2qLu5eqLuNYgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333199; c=relaxed/simple;
	bh=GPNtDaDinweeeNRE+lD7M+Kk13rvwH5XMW6tRwPLK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHQAmFz+w7HntGkr+lSN/aofkYakV2UNTUyWzig6mkET/McmhxB7ZxUwlAadwwJhAdgj3rH4bMYQs1K5vHwtWCbz5ICMqMbk6T/fVlK28eW77IDq9PsbPyQS9dJ8suxaIC1yS70XdcWpbmTYhJ1s86SpduJXq27LTY9c836Mtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hp0yl9dN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773333198; x=1804869198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPNtDaDinweeeNRE+lD7M+Kk13rvwH5XMW6tRwPLK+4=;
  b=Hp0yl9dNuoNEhUuTShn4GNo3n1816wiK7cbhRNTP/mimVcklckqTIchK
   /r6zCeGqvJ2RqfxUuwH6VWduaRVrAVIMnzXN+HPV/lI8AUKeEDpMCViqN
   WeDeqV74zx5Bt2in8A76r7AWEccRwpF5eYwNqH6sUj88QGxwu95eKTsgi
   T1G4wSPLXUd+ANrrBE3q04BDRVfT+Lkie/fa76liuSAYyzfFmzTylYlAY
   of/3Pyejltf0U1b1O98pK8hUGT8MvjmtxNNCCmVRALpqYGJmfqSX2NLPX
   QYpZbAWlfJS1g/lFM0QaYB1ynw1JFr3J8/gqzdsVkUFPBLeTlKrJDdTpX
   g==;
X-CSE-ConnectionGUID: q5+eOc9qSpGafGHu3aE19g==
X-CSE-MsgGUID: P7fRKQUjQIeFOIY4lgyXKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74349214"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74349214"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:33:17 -0700
X-CSE-ConnectionGUID: 1YY5csTKRy6iBC2DxRBP3A==
X-CSE-MsgGUID: p7syge5aQIOf1CHH3f8X6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="246213940"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2026 09:33:14 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Steve Rutherford <srutherford@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Decotigny <decot@google.com>,
	Anjali Singhai <anjali.singhai@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Brian Vazquez <brianvv@google.com>,
	Li Li <boolli@google.com>,
	emil.s.tantilov@intel.com
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB enabled
Date: Thu, 12 Mar 2026 17:30:24 +0100
Message-ID: <20260312163025.3765321-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
References: <20260227203457.558196-1-srutherford@google.com> <20260227203457.558196-2-srutherford@google.com> <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com> <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com> <8b43d234-867a-481f-90e6-e155132100a5@intel.com> <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com> <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com> <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267161-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 3A519275B48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

From: Steve Rutherford via Intel-wired-lan <intel-wired-lan@osuosl.org>
Date: Fri, 6 Mar 2026 11:35:27 -0800

> On Fri, Mar 6, 2026 at 6:52=E2=80=AFAM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Steve Rutherford <srutherford@google.com>
> > Date: Wed, 4 Mar 2026 14:01:46 -0800
> >
> > > I believe syncing twice isn't inherently wrong - it's more that you
> > > can't synthesize the header via the workaround and then sync, since it
> > > will pull the uninitialized header buffer from the SWIOTLB. Outside of
> > > SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) they
> > > are copies from/to the bounce buffers.
> >
> > Ah I see.
> >
> > What if I add sync_for_device after copying the header? This should
> > synchronize the bounce buffer with the copied data I guess? A bit of
> > overhead, but this W/A triggers mostly on stuff like ARP/ICMP, "hotpath"
> > L4 protos are fortunately not affected.
> 
> That should work fine as well. I'm not certain I have strong
> preferences on the right answer here, other than "does it work and,
> ideally, is it less confusing?" The patch I posted is a bit
> unintuitive. I think what you are describing might make the workaround
> self-contained.

Could you please test this patch with SWIOTLB? If it doesn't fix
the issue, you can try changing `page_pool_get_dma_dir(hdr_pp)`
to `DMA_TO_DEVICE` and/or `DMA_BIDIRECTIONAL`.
Currently, I don't have any machines with SWIOTLB unfortunately =\
Let me know if any of these works. I'll submit it properly when we
have a solution.

(the patch applies cleanly to the latest net-next and should apply
 to a couple older kernel releases as well)

> 
> thanks,
> Steve
>  [And sorry for my gmail-driven top posting crimes D: ]

Thanks,
Olek
---
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 45ee5b80479a..42111d56d66f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3475,7 +3475,8 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 			     struct libeth_fqe *buf, u32 data_len)
 {
 	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
-	struct page *hdr_page, *buf_page;
+	const struct page_pool *hdr_pp;
+	dma_addr_t hdr_addr;
 	const void *src;
 	void *dst;
 
@@ -3483,16 +3484,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 	    !libeth_rx_sync_for_cpu(buf, copy))
 		return 0;
 
-	hdr_page = __netmem_to_page(hdr->netmem);
-	buf_page = __netmem_to_page(buf->netmem);
-	dst = page_address(hdr_page) + hdr->offset +
-		pp_page_to_nmdesc(hdr_page)->pp->p.offset;
-	src = page_address(buf_page) + buf->offset +
-		pp_page_to_nmdesc(buf_page)->pp->p.offset;
+	hdr_pp = __netmem_get_pp(hdr->netmem);
+	dst = __netmem_address(hdr->netmem) + hdr->offset + hdr_pp->p.offset;
+	src = __netmem_address(buf->netmem) + buf->offset +
+	      __netmem_get_pp(buf->netmem)->p.offset;
 
 	memcpy(dst, src, LARGEST_ALIGN(copy));
 	buf->offset += copy;
 
+	/* Make sure SWIOTLB is synced */
+	hdr_addr = page_pool_get_dma_addr_netmem(hdr->netmem);
+	dma_sync_single_range_for_device(hdr_pp->p.dev, hdr_addr,
+					 hdr->offset + hdr_pp->p.offset,
+					 copy, page_pool_get_dma_dir(hdr_pp));
+
 	return copy;
 }
 

