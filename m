Return-Path: <netdev+bounces-253934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIsAMMDleGl1twEAu9opvQ
	(envelope-from <netdev+bounces-253934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:20:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAD97A84
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09E123038F12
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698E35CB9F;
	Tue, 27 Jan 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgMgpG0G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5B356A17
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530628; cv=none; b=OgFw/qF3285XvSSyWE8GUeLqE5Yp49y7ROZTpiUw5VfR0VXPGj3aLgd5t9WL9Hl39A1aDnbbz0laqmG9WGQ+rr0UCtlT2tU1FOSNrTj2FtQOWz5H78IKQR/L42mWTEnXwCxFM9CYhUoK39GYt/rM3xodyeiM8aVZVMmS3P7/8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530628; c=relaxed/simple;
	bh=WU3PWO8MGnvuCjUuzy5ZCcTuhPmzibJYY7sZ+sUEuGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BTC9oE7t2tUVyDjVmV37V4wdyK08gohXRm1QqTgCldfEdjdFfUMlsAzqTSonxiFDPlndd9idlCX4brZZlVWADCm976HNa4q0PvAYZJisaiwjyzucSkGfZwc1MokIh8+WS+QBQKhxBAl2DFDOhcNkkNdn2JaRBRhp1nixYMP9aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgMgpG0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA186C116D0;
	Tue, 27 Jan 2026 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530627;
	bh=WU3PWO8MGnvuCjUuzy5ZCcTuhPmzibJYY7sZ+sUEuGM=;
	h=From:Date:Subject:To:Cc:From;
	b=bgMgpG0GX5YumL2WfrfXQJi4LH60lD5EdnN9vgvoYuhR+bxMecTD41F2rxNBS1o9j
	 MkTKc0LwKr8J4dE2PZKIlTh6LvfO7KYil4Bob/lEM8mvLOsPnMIyq8HXYpd3g+aXQD
	 nHJPjrQmdKAieWJyPwqeVj5YzFIZu82IF4EmV6j51FO5b3+F+I4cl1vDMmMQqTQl0i
	 ntMip3n8ZlZXJsfN07n3TcHU7Xn4GhN/aSaxOb7lalIsJ+3Th7c0TMfu4+5u9Tgfq/
	 07IpoLEXkRHIH1JYRxEFu5ag307WstWfrruuhngbOgE56F0syGw+aptIF6FV93CxuK
	 DE4u7hEdGB+Xg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 27 Jan 2026 16:16:55 +0000
Subject: [PATCH iwl-next] ice: Make name member of struct ice_cgu_pin_desc
 const
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-const-name-v1-1-9c84615c55a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPbkeGkC/x3MSwqAMAwA0atI1gba+gG9irioNWpAo7RFBfHuF
 pdvMfNAIM8UoM0e8HRy4F0SdJ6BW6zMhDwmg1GmVtrU6HYJEcVuhI0yzg5DUemihBQcnia+/1k
 HfK0odEfo3/cD4OmOBGYAAAA=
X-Change-ID: 20260126-const-name-902cabb35134
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253934-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40FAD97A84
X-Rspamd-Action: no action

The name member of struct ice_cgu_pin_desc never modified.
Make it const.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 93901bccf1c4ae1e1782e7a2af4322a6777d0b6c..87aa4cfc5a463f74509ecc4cfbc00e06f26cab5c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
 };
 
 struct ice_cgu_pin_desc {
-	char *name;
+	const char *name;
 	u8 index;
 	enum dpll_pin_type type;
 	u32 freq_supp_num;




