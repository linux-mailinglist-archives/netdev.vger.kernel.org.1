Return-Path: <netdev+bounces-272958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEgwOxxpyWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:02:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A1353790
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECBDA3003807
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8F1A680A;
	Sun, 29 Mar 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="E7S6Q0jM"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B507262A6
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807322; cv=none; b=YRe7hw+eDWfmvRUsPsVxP8um2DjbNiSQy5dEsQPbg/J6h3V/UPfEBg8k/k5dkwD9nMpU6UBM//lXgFYXcxG0sy5t5OqB8s8Tn7iVKL4pLvWmYbHqjCwIbKOiQE5Q98uJbyIQpOHGUmGdRenM62LTze+ipHcip3g03ZsaiPPJ2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807322; c=relaxed/simple;
	bh=Z7yPjBlxzWnY0WEs+XWuOySIJH3uvekOICh+2YsMOF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXs6MQjXfIcTXriMPPSv07Ou+tbucjvfh5GJR+DX3xfQ2LBu03IZ2FiATZTa8tDkqFjShujgTcznPxUx6cTFOQ7vPSsBBA2D0njTTbIBV2PobLeSkTeUVsycxqeMSVzTfF/LvcLX9ttpYSoh8UXfZ99fxRvpTHsYXddavTTTnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=E7S6Q0jM; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (69.51.30.125.dy.iij4u.or.jp [125.30.51.69])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62TI14S0044939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 30 Mar 2026 03:01:05 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=ZEMA6x+zaezt2rZ2Eio2ebLz6Teucj8wxLdI4HQ7fWE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774807265; v=1;
        b=E7S6Q0jMYbKwnCcLGRDnJu6esZo7CrFHs73ZxTzVn1bYG7aL9hLdQ13LhGehYcRe
         FuyuLdHSJRGkDZbTH86ODQVnncc38U5V1QtlyPdYutyrdCe6I8ydtvgh5nNN6K+b
         QW90sbkXx6Rz97phBG02SAYHgv30FQ8FhfYN1dKRzUFnVDZ1fEOWt3OgPX1Pd5wI
         czIDnbc7GZn2hcwPgIFzypBGD8hDq1vicqo3MitDBw0M6vGYUrtwjfLNeJTp6Nic
         9B4ry+R/+/wUlAYdV4weyrT81WEYuhm9ukvZbZT4r85x6OH9zo18rZgEfdJ/Koyw
         OoyvppRuKwvIHvPF4mYvcQ==
Date: Mon, 30 Mar 2026 03:01:04 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        jacob.e.keller@intel.com, nxne.cnse.osdt.itp.upstreaming@intel.com,
        horms@kernel.org, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
        bpf@vger.kernel.org,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 3/5] ice: migrate to netdev ops lock
Message-ID: <aclmhA5yjXfzX_Jk@x1>
References: <20260325200644.2528726-1-anthony.l.nguyen@intel.com>
 <20260325200644.2528726-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325200644.2528726-4-anthony.l.nguyen@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,enjuk.jp:dkim,intel.com:email]
X-Rspamd-Queue-Id: 902A1353790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/25 13:06, Tony Nguyen wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Queue management ops unconditionally enable netdev locking. The same
> lock is taken by default by several NAPI configuration functions,
> such as napi_enable() and netif_napi_set_irq().
> Request ops locking in advance and make sure we use the _locked
> counterparts of those functions to avoid deadlocks, taking the lock
> manually where needed (suspend/resume, queue rebuild and resets).
> 

I've been testing this series and found that attaching XDP program
hangs:
    ip/1033 is trying to acquire lock:
    ffff888103d8ec30 (&dev->lock){+.+.}-{4:4}, at: xdp_features_set_redirect_target+0x1f/0x80
    
    but task is already holding lock:
    ffff888103d8ec30 (&dev->lock){+.+.}-{4:4}, at: do_setlink.isra.0+0x261/0x39a0
    
    other info that might help us debug this:
     Possible unsafe locking scenario:
    
           CPU0
           ----
      lock(&dev->lock);
      lock(&dev->lock);
    
     *** DEADLOCK ***
    
     May be due to missing lock nesting notation
    
    3 locks held by ip/1033:
     #0: ffffffff86d8b548 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x6c4/0x22a0
     #1: ffff888103d8ec30 (&dev->lock){+.+.}-{4:4}, at: do_setlink.isra.0+0x261/0x39a0
     #2: ffff888104e1c5b8 (&vsi->xdp_state_lock){+.+.}-{4:4}, at: ice_xdp+0x96/0xef0
    
    stack backtrace:
    CPU: 1 UID: 0 PID: 1033 Comm: ip Not tainted 7.0.0-rc4-enjuk-tnguy-00940-gadae968a1b0a #316 PREEMPT(full)
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x6f/0xb0
     print_deadlock_bug.cold+0xc0/0xce
     __lock_acquire+0x123d/0x1b90
     lock_acquire+0x192/0x310
     __mutex_lock+0x193/0x2860
     xdp_features_set_redirect_target+0x1f/0x80
     ice_xdp+0x64d/0xef0
     dev_xdp_install+0x3c4/0x840
     dev_xdp_attach+0x50a/0x10a0
     dev_change_xdp_fd+0x175/0x210
     do_setlink.isra.0+0x1c1b/0x39a0
    [...]


I think we should use locked versions for both
xdp_features_{set,clear}_redirect_target(), and this fixed that for me.

---
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3477c53316ba..0be225ab9372 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3015,9 +3015,9 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
                                goto resume_if;
                        }
                }
-               xdp_features_set_redirect_target(vsi->netdev, true);
+               xdp_features_set_redirect_target_locked(vsi->netdev, true);
        } else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
-               xdp_features_clear_redirect_target(vsi->netdev);
+               xdp_features_clear_redirect_target_locked(vsi->netdev);
                xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);
                if (xdp_ring_err)
                        NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");


