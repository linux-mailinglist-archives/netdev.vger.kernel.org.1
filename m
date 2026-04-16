Return-Path: <netdev+bounces-279034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLb/DMzV4GmMmgAAu9opvQ
	(envelope-from <netdev+bounces-279034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A603C40E213
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C913D30724D0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D13B6342;
	Thu, 16 Apr 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="azmFppuX"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DED37C924;
	Thu, 16 Apr 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342451; cv=none; b=QwVa6Z7IZ4l1gwqIMG8lK09VjvT69SW58Qa8vUcT8qU/ryu33oKuTD3uloLV6Wm2hyHRsT+CjzVdKy4IL6SQMKTI0cnbunfAz+ObcxCBG3fEfca3HY7Y2zugXutrfWBtGR2ZNS41ZJrxxi4yOZlQJz7BukzBYef1rdr97vq8suQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342451; c=relaxed/simple;
	bh=Fnra5qsBCr1ftQm105ZSYM+D0zJ7L+SRwxnkwFAJpoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOTKrngE59Dls2Lb0FPCqj4HFr6E/oTZsI53NYYI2TdBR2Jm/g/jP0887+tFapKGfuS3ASiY7RnLzEwNu57V2wYfqRYVovIgKK0aDQ7xsdNp/mL1JPyPcm0h4NTM9VhLUVEkVjXZp64ugI/cVR3m5UTy8zsftUsPiyepmVauKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=azmFppuX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=g3IoSnLHf3c7m8lpmywYWg24E1za4lFs3bvdoX3kcPk=; b=azmFppuXNPdamvwTFe0xE9qbD9
	c3r3u3imBt/Xa1KPGpRrOE9Sq51I4WwxCnRjg+XAWOdCh+jSq4rd5FRYEtt8usntnXJMTpVXijFS4
	5t+ZNERMTTUXWc1tUBltTUY7CZ5fnHAzUwi+SXVLFaWeWg8Dhi2pVS6+ZzOMSVw2iwb0Z9s5Hwb1W
	6gq4psznTbFBorMwIhUuclo0ySl24uLbH+mEjcYa4xns6dw8SBHxMyQ1QeAG92Bn5f44JfIGGnwnf
	GbBn4PVCVLaFLxEsfNFfVk5FEGaSHWGULJPx1x6X7vIMcBenov71MxZIwCgUUxM4ddlJPWsAMZPV9
	OQZoS10A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDLoV-000Ftl-2p;
	Thu, 16 Apr 2026 14:27:20 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH bpf] bpf: Fix precedence bug in convert_bpf_ld_abs alignment check
Date: Thu, 16 Apr 2026 14:27:19 +0200
Message-ID: <20260416122719.661033-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27973/Thu Apr 16 08:24:10 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A603C40E213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix an operator precedence issue in convert_bpf_ld_abs() where the
expression offset + ip_align % size evaluates as offset + (ip_align % size)
due to % having higher precedence than +. That latter evaluation does
not make any sense. The intended check is (offset + ip_align) % size == 0
to verify that the packet load offset is properly aligned for direct
access.

With NET_IP_ALIGN == 2, the bug causes the inline fast-path for direct
packet loads to almost never be taken on !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
platforms. This forces nearly all cBPF BPF_LD_ABS packet loads through
the bpf_skb_load_helper slow path on the affected archs.

Fixes: e0cea7ce988c ("bpf: implement ld_abs/ld_ind in native bpf")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a10cdcb7103e..35f5ee7af64e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -508,7 +508,7 @@ static bool convert_bpf_ld_abs(struct sock_filter *fp, struct bpf_insn **insnp)
 	    ((unaligned_ok && offset >= 0) ||
 	     (!unaligned_ok && offset >= 0 &&
 	      offset + ip_align >= 0 &&
-	      offset + ip_align % size == 0))) {
+	      (offset + ip_align) % size == 0))) {
 		bool ldx_off_ok = offset <= S16_MAX;
 
 		*insn++ = BPF_MOV64_REG(BPF_REG_TMP, BPF_REG_H);
-- 
2.43.0


