Return-Path: <netdev+bounces-109471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81561928966
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2222BB22C13
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774D149DF7;
	Fri,  5 Jul 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWsookLm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C242AD39
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185343; cv=none; b=eNFn+Yw7NSmlxxShynxlAQ//HwSsHDen6o8j5z+WDGUxMwmhFwy5OYRJZ2Z6FPcmK3cWIZJaoHWBFeAVbUTVMtkbAlI1jAwF1Mh1O+AHlUo9ZmDkpYpnUNQykJyYAcao5L8Yp0zdUjfrlqELVYThSvSInyzNccxAK7V9AwKcaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185343; c=relaxed/simple;
	bh=DxcxTZVuuNTU4W0/gz5O/gSVTAwCzeA90soDR50/TgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rTz/Hj01nRsnndCLgwNwDZ53jFUyqc9ZQTKR4tBhAjgtGBtH2tiziD+7CR2Jn/nUTUKuoxr+4lQ4XUHDFD7Xu6tcaFDL9S5WADobWr64h5fgnMhmzKyL9EzrknWp6V8Gvax2t/P7O/i4jdrNXqM4kgRNj6U0S8ptHFGQozUHOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWsookLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD64C116B1;
	Fri,  5 Jul 2024 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720185343;
	bh=DxcxTZVuuNTU4W0/gz5O/gSVTAwCzeA90soDR50/TgQ=;
	h=From:Date:Subject:To:Cc:From;
	b=TWsookLmYHt5LqPLjdaGWrMG0zU85RgXg+qpOSF03Tz8eNLuTFpRwq4nQZPUL9jIL
	 SmZfJvI4wi1R715t+jg3fd8+ZFzwmnqZ7lY/ZNz3axjORtKojgoTKAy2e0am+HuAna
	 UDmOcxsNVzzj0oYZ6zTG8fmHXC22Z6XAKWwLe6+5bvFsvcAaIa9yQyjvfemvPsJXlZ
	 ZXaqZj2MpmQzsLmKW1lTxvZamChLuGm5w5gajoQawD4Gf2AIE6PeotNCUN0ke3LKQb
	 nG5h0Q41R5AeX7N12y6WPMJD4227WdQR6RcRIIcIXz6wdA1GohUjPUYY3DLEqktQkJ
	 cYb7JY08Md0EA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 05 Jul 2024 14:15:40 +0100
Subject: [PATCH iwl-next] i40e: correct i40e_addr_to_hkey() name in kdoc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-i40e-kdoc-v1-1-529d0808a1ef@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPvxh2YC/x3MQQqAIBBG4avErBswKYKuEi1Ef2soLDQqkO6et
 Pzg8TIlREGiocoUcUmSPRQ0dUV2MWEGiysmrXSretWxtAq8ut2ygdPe9KaD9VT6I8LL879Gknv
 jgOek6X0/qGwv7WUAAAA=
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Correct name of i40e_addr_to_hkey() in it's kdoc.

kernel-doc -none reports:

 drivers/net/ethernet/intel/i40e/i40e.h:739: warning: expecting prototype for i40e_mac_to_hkey(). Prototype was for i40e_addr_to_hkey() instead

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index bca2084cc54b..d546567e0286 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -735,7 +735,7 @@ __i40e_pf_next_veb(struct i40e_pf *pf, int *idx)
 	     _i++, _veb = __i40e_pf_next_veb(_pf, &_i))
 
 /**
- * i40e_mac_to_hkey - Convert a 6-byte MAC Address to a u64 hash key
+ * i40e_addr_to_hkey - Convert a 6-byte MAC Address to a u64 hash key
  * @macaddr: the MAC Address as the base key
  *
  * Simply copies the address and returns it as a u64 for hashing


