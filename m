Return-Path: <netdev+bounces-257239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMO+GMe8hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B09DCF4CBD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63A2302BBB9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BAC42981B;
	Thu,  5 Feb 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Z5AQtUex"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB33429818
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306593; cv=none; b=U/VI26nYtoGsa1p40KNV74GXT3S0kY0JkTEETeQiZJCqUzpADwXfCtZsoB/fIi/fqamRSeCRAMJl+9nhNMzzPumMKEvTwDkn1XQMprNHIXecP9RgMp0S/ps+tzpC5Fcbj6OJMWEvT4cQoit+2UP+kQY1GLG6rBQd/VZiok8BF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306593; c=relaxed/simple;
	bh=6CJQ+M31O8EVOiXo21e+ShRZ0u6bO9nTVmOBgZ2GIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHPuALtoORU/KTvuhdUsE2Los2wLYy8hUPqTvJjLeP2XtSyTUEJTYhyHzScoLY3o1r7Af8vU+mXgTpCcjx8im9IfPUzL7MU95MYhPz5fiuHLokjk7lOwijJp/sG2MHk0cKkj+XqO0vFij8hGniQBye6HmomvOWUNmnAIQ04XH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Z5AQtUex; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 615Fnh3S027695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 6 Feb 2026 00:49:44 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=mbHqqpvf1EsyENiG3xgpDiZNiWcRfgRHeO49XVCu+yQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770306584; v=1;
        b=Z5AQtUexhixK+Evq42B8d88+dTevYkDrD7m1v+MP4Jt9tmDqwJG0wED8E0kmMWIj
         PTFFjGjlvaOqrZIBoDWKjILFsh+T+NRwhvfMvFLCt51ewz40oos1n4lyS/qYhvyk
         tt4dr+XX9nrkwx0J7+eYfifdQoHYp+TcBrK0QeUQ0ktTIiGRG0xkUkoLe2wlyMzS
         RkiSMcQxQB/B+eaQq6VirsZx55l94TyXXR+gfXOuNfCODP1ARKVCBzzkQuGwupwm
         hZh3gdCzwnOxbQWlIVG5+LHzsyGWXQNit23NsCmc3y8IDYfuux2mMYEMD4pd62qE
         /M7J1cWoO6/88HrM5TNonw==
From: Kohei Enju <kohei@enjuk.jp>
To: vitaly.lifshits@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 iwl-net] igc: fix null pointer dereference in
Date: Thu,  5 Feb 2026 15:49:43 +0000
Message-ID: <20260205154943.20985-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <3b481682-5a64-412e-a085-8d3c6323dd4e@intel.com>
References: <3b481682-5a64-412e-a085-8d3c6323dd4e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	BROKEN_CONTENT_TYPE(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257239-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:mid,enjuk.jp:dkim]
X-Rspamd-Queue-Id: B09DCF4CBD
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 12:16:06 +0200, "Lifshits, Vitaly" wrote:

> >> Hi Kohei,
> >>
> >> Thank you for your patch.
> >>
> >> Since there are no NVM-less devices I suggest removing the flash-less
> >> code entirely from the init flow.
> > 
> > Oh, I see there're no NVM-less devices. Then removing sounds good to me.
> > 
> > Could you clarify what you mean by "init flow"? Do you mean removing
> > only the flash-less branch in igc_init_nvm_params_i225(), or removing
> > all flash-less related code including igc_get_flash_presence_i225() and
> > its callers?
> > 
> > After clarification, I'd love to work on it. Thank you for taking a
> > look!
> 
> No, you shouldn’t remove this function.
> 
> However, if for any reason the flash is not present, the driver should 
> fail initialization.

I see. I understand we should fail igc_probe() for NVM-less devices.

> 
> There are two related places that need to be updated to enforce this:
> 
> igc_probe() in igc_main.c
> igc_init_nvm_params_i225() in igc_i225.c
> 
> This way we avoid supporting a configuration that doesn’t exist, and we 
> prevent the driver from partially initializing in an invalid state.

As far as I've skimmed the code, the only call trace is:

igc_probe()
  ei->get_invariants() (always igc_get_invariants_base())
    igc_init_nvm_params_i225()

so modifying igc_init_nvm_params_i225() is sufficient and IIUC we don't
have to modify igc_probe().

igc_init_nvm_params_i225() returns -EIO when there is no NVM, and its
caller igc_get_invariants_base() propagates the error back to
igc_probe().
Note that igc_get_invariants_base() currently ignores the return value
of igc_init_nvm_params_i225(), so I added that check as well.

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 1613b562d17c..e4200279e15f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -235,6 +235,9 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
                break;
        }

+       if (ret_val)
+               goto out;
+
        /* setup PHY parameters */
        ret_val = igc_init_phy_params_base(hw);
        if (ret_val)
diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 5226d10cc95b..ee1a8eeed9d5 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -476,21 +476,17 @@ s32 igc_init_nvm_params_i225(struct igc_hw *hw)
 {
        struct igc_nvm_info *nvm = &hw->nvm;

+       /* fail initialization for NVM-less devices */
+       if (!igc_get_flash_presence_i225(hw))
+               return -EIO;
+
        nvm->ops.acquire = igc_acquire_nvm_i225;
        nvm->ops.release = igc_release_nvm_i225;
+       nvm->ops.read = igc_read_nvm_srrd_i225;
+       nvm->ops.write = igc_write_nvm_srwr_i225;
+       nvm->ops.validate = igc_validate_nvm_checksum_i225;
+       nvm->ops.update = igc_update_nvm_checksum_i225;

-       /* NVM Function Pointers */
-       if (igc_get_flash_presence_i225(hw)) {
-               nvm->ops.read = igc_read_nvm_srrd_i225;
-               nvm->ops.write = igc_write_nvm_srwr_i225;
-               nvm->ops.validate = igc_validate_nvm_checksum_i225;
-               nvm->ops.update = igc_update_nvm_checksum_i225;
-       } else {
-               nvm->ops.read = igc_read_nvm_eerd;
-               nvm->ops.write = NULL;
-               nvm->ops.validate = NULL;
-               nvm->ops.update = NULL;
-       }
        return 0;
 }

Does this diff make sense to you?

