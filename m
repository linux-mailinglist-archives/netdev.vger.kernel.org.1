Return-Path: <netdev+bounces-262592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFvyIMxhpWmx+wUAu9opvQ
	(envelope-from <netdev+bounces-262592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E021D613A
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0803E30364D1
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFF395D8C;
	Mon,  2 Mar 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfQfNc66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D729D29F
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445741; cv=none; b=Oi3TYXCb4Mp2aii9MLZmMD+/WdgyJRp3lJuPhJ2c9soA03sGBYZ7I4exszX05KiT6eio1JDf3TYyQ6cie0qLPpVyQquAhYUgn+tFgyudaWtqqk4G+9lY8s4Ri2OXYKZGdXzfmjk1csUFIZKxdZGnJT8DkTIbXYAsNMQPHkYNilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445741; c=relaxed/simple;
	bh=rcnS7IdkUDdkrozKgEJrZX4dzQsaJ6e9KijTjrwQa7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uELXgTVEUMCuDaBR+UFSMxeXK2bhrf/WV2ouXbilbzVDlCMInTyFKN6tEPCCxcarpIHA3jRNU+QtemM+17acsnbrTQNptxZaHTsqL8H1NGr+auRhVyBe92kZTgVkqPUXzAwM5/Ih8GZoBvPMVm72z95a5pYPDe0oZDsOkPs/Elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfQfNc66; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e1f417918so1185881a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 02:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772445740; x=1773050540; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyc4r+7xdW5UIIQv/i0wzsrtOCUobKuGa1F7pXMAHjQ=;
        b=EfQfNc66TS02ScyzZELKlHVg0wNXX3nUY3XqP+98U5wuLOmOr5a8rHiXnF3YPqkGMI
         dPCSi3eAg95rxWjfaNm7TfuFHSz5PkM9YmBvs4dDi97pM2XxfZKPNBWdUBw/WFYGrD8P
         fcVD6UB1mCaT8pVDiCIUN/f5dag2GYyg15Fm4M86M5S2ldlDUea/DOgtwffJEkQEiAhv
         AqEPuI69d1Aai9R+4FCHc1/E54xCoT6YZeS2Do7LHMDXZXDO5BPPqglNIVanUGLER94L
         Z1ceCINeXToueKUv94A9mVhJP8O0HwznspyylDelc4tzGfO2WBwWwEN3NMZ/590x8T/O
         eRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445740; x=1773050540;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyc4r+7xdW5UIIQv/i0wzsrtOCUobKuGa1F7pXMAHjQ=;
        b=pkKCiDKaw7UXA72jwraRZqByb3W2Y93r4n2l4V9SACDcn7RWwFNXAvGxbfVIps6QgM
         kqxSdo5+O7Xu6MLF0F9GsxsfeUJIA+fPndGF7mQeX4AjMZ6YhQzsmImvI36maApxFL6c
         xi1cYyejuif03IlsKRzxA8gvKQBliIpAup6DWgILhN99MqDL7zszg0Bi4cdqAUJiM5VI
         YpTClptorMKwcYPlGTJU3ht+QoOq80XUnmuCPtDCNMF5jAPK39ANrmOTPNoxjep2DUwQ
         wbzNgHaRLyvFVT9S8mtOXRE1RMeBBr+761eVIFr1bUTQWQQUTMHtSyfw4JpUS/zJYbIj
         pPBg==
X-Gm-Message-State: AOJu0YxjnW522LQvmDCBYbesHVfm8epO5AtatijQzUBPZ/9zqOBESlmF
	X9YCzoZY4dV25clbb+z8uhvphLNV0Q2vOmd+bI4Lr1b/qraIRIsuSIXj
X-Gm-Gg: ATEYQzwdimf0H5jAkO7OA2NakVFj4Yhlm6+GB3YnFWhndTzAUN8hiYI1sRf8yIkHSgc
	C9bpBGjYlB70+OK3Efc0k3h17edxM8XOswJEH9DD4gFmYSzO/wmy09CAwl5XFlZl0WwMr9pNMYP
	Tqm2GZlnFaH3+1IYpQgPvYryy62bsuONm17IqYzB7Kgk1Jgg9V9GddWWyq3NxrV3JVj6OLqg15j
	ptnH7r7U03djvANeEKTGuJfk22Z9s1INaviZ7CQ1VpegL2dAzDfhrLJWDU51n4GNk37KrezDPpA
	CZpQkmh/2uACGn7ZM5w+4VbuIWjoHz6F4j4s0TKDeNHEoQfPoTDWnFTBt9JZyhWn2xr6nFXTFpZ
	9ALdiIeAIdVKpFNm05sY+LqBo4uNSFjU5naA5+tN8tM7PYenIAolXrYIabkoF6Get6ill/BTJNp
	K2e5UfOUnQxVB7Ni0gsdSuXtt3Ho8Jz0FIuDrwKWjZag==
X-Received: by 2002:a17:903:2289:b0:2a0:e223:f6e6 with SMTP id d9443c01a7336-2ae2e4d6622mr127702525ad.46.1772445739588;
        Mon, 02 Mar 2026 02:02:19 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae534088c4sm27256985ad.26.2026.03.02.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:02:19 -0800 (PST)
Date: Mon, 2 Mar 2026 19:02:15 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: antonio@openvpn.net, sd@queasysnail.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] ovpn: Fix race condition in ovpn_dellink()
Message-ID: <aaVgJ16edTfQkYbx@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262592-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 01E021D613A
X-Rspamd-Action: no action

When ovpn_dellink() is called, it invokes
cancel_delayed_work_sync() to stop keepalive_work before freeing
the device.
However, ovpn_nl_peer_new_doit() runs without any lock shared
with the RTNL path, so keepalive_work can be scheduled after
cancel_delayed_work_sync() returns.

The following is a simple race scenario:

          cpu0                            cpu1

ovpn_dellink(dev)
  cancel_delayed_work_sync(keepalive_work)
                                   ovpn_nl_peer_new_doit()
                                     ovpn_nl_peer_modify()
                                       ovpn_peer_keepalive_set()
                                         mod_delayed_work(keepalive_work)

To prevent this race condition, cancel_delayed_work_sync() is
replaced with disable_delayed_work_sync().

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/net/ovpn/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..ada73dd35ba4 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -212,7 +212,7 @@ static void ovpn_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
-	cancel_delayed_work_sync(&ovpn->keepalive_work);
+	disable_delayed_work_sync(&ovpn->keepalive_work);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	unregister_netdevice_queue(dev, head);
 }
-- 
2.43.0


