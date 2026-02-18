Return-Path: <netdev+bounces-259248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALtOFBePlWl7SQIAu9opvQ
	(envelope-from <netdev+bounces-259248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:06:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE515518F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769293062961
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07E233D6D9;
	Wed, 18 Feb 2026 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2gJ/J42";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcRAViZX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001F28150F
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408932; cv=none; b=a8beyEZbsSkea7wyZRfdjEaOsDA3YnmI8vyaZJQA3si7pooZuhAq/s9z7jtO1CUOmK5WR5vWXzNJKUpwWKKPrjHeNk0DATzwvfCSwjy9qpkR8aH1mViFW6JdF4JofSBicHmSv7C9Cpb3A7LSsZSB+EIafsb2t/Vdijow/sU/wRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408932; c=relaxed/simple;
	bh=a339kBkybaGy7z7bYIn3mQ6IO2hh0pPgRs7EW/56fR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfgqFcP0cZiDoHE+OyoR16VaOnLPSs+kUeXuUwxzwzuopV6RxClsTiUS6WsKN5N+uCAOwK8DHL2LSfuM2Xyprabj2miMvzoSm8Z+pRBPbfwH3YwO581KEm6m6FZVWVGiWyo3OIQUUmfMHamF4AvGkX6Em2kyVkvru+Lj6BEjzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2gJ/J42; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcRAViZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771408929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eK3uR170viBUHbHogyb7PZrSIT9cVl8hPawQihOLUtk=;
	b=C2gJ/J42kkY2rKHkmDM6Aps3LUjvuLH2wvOzyO7V9zHWJk8ejHW67hCqGfkaDsCMd6zmYs
	lEC49+MNB8+VVW3BX2P5WGNDKd+Tcv3uNcCHFh5VaLFGmluAeHEQRffhjf1zsXdKhTercQ
	qdQiUkFGgI/LByjxJ28FcHXyLn0CrZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-DFHlJbV0OaaT2o4AcSE_8Q-1; Wed, 18 Feb 2026 05:02:07 -0500
X-MC-Unique: DFHlJbV0OaaT2o4AcSE_8Q-1
X-Mimecast-MFC-AGG-ID: DFHlJbV0OaaT2o4AcSE_8Q_1771408926
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836b7fbf4fso41336325e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771408926; x=1772013726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eK3uR170viBUHbHogyb7PZrSIT9cVl8hPawQihOLUtk=;
        b=RcRAViZXY50eESz+PbwBiaDVgKtdLcd3Oaa+CVfl00/CMa0cuEqSGeLoRskbZKO/x/
         YVc1iM1PrjaF2L4z/vTI0yH4WXlNBVUBi2UsAd+3uNNcvY8tVTPIa2LacUJYE+sAjNSF
         XzPeUZ9cxVHeTiXJ8EFcO3ztsi4Ivi3o+6RxU7Z/1ESXC/sYcS2hH6sljO4GAlQ1rXQX
         rD3PoJKJl2lHSJj7g2DF5FUdKr9OLUUPqoMOG+s2yIWGn7DGO0yT+2nO4XFSg3Zq62zJ
         dby2iiHCSZIhtYwbHahwDJQjc0T6qnyTdhlDGuVHYvW/bC2xoh0RkmFLRMb9MHmMU6w0
         iydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408926; x=1772013726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK3uR170viBUHbHogyb7PZrSIT9cVl8hPawQihOLUtk=;
        b=ALJmPZXJ2XKQrBgOfPJ0hRVwnZ00CoiNs8w0TPeAup9cj3rRAKMmoCnoxNXpe9pvI1
         DkgZVJFVnuW1w70Htj6wwmBOO2wKr1MHxhdohprzFNgnvr5yYXmpejx9FRtxQyhyAeTN
         YxePlLLPyqdAyFzQsDcgfd4UdQkgpXt3U3vmkM4enIuknP0l83CE5Dsvc+zyU7EyXEmd
         RjlPVPI9czl6zAJHRf0i8/CmsIKIzx/nS0zo9FhS6t2n9IAolE5nuZgocuGHImjOENAa
         KmgGQFljeLPOsedQnoWXYkpnSxrlbjC+j2m8qaj8rGbeGM32+GdWPUYXQHo17jXPksvL
         KGRg==
X-Forwarded-Encrypted: i=1; AJvYcCVsSPq1TSOsMcYvbMFVuOQv0hFR/gsi5tWUGkZXjbTU/67hjeHMGStjZRNslI6rK/YEs0jv2oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtmgKEhFvGasLnmvoFx4K0uN1Wmd1xAxRMrFI1DtTyWDaKz9N
	LOk5o1fqb+zaMWT+biJBH4+j2jlU2sBn5jq8SO+P8sN2B2Uty0rnIUG09layzo08p30TPXhsMxt
	m9qV9qCfVr25JG6y7TwktcH5cMncUzaDMEGR+Xs5PVHTRwXLCVsjldxrh6g==
X-Gm-Gg: AZuq6aJGZRC2IgfDVn2yIF3VwvOZlkmhi8xJLbIVTnLv2X0T2dZSK0oMjJffh+gPpzo
	H+WyAp59KQFy97KesFjWp202IdBqVtM2l+KrbtDX1njccwjvY5km3pziyQE+GjQahUp3gwxp4Fw
	2OeHQC0QtjcI1U13VTHfwmE561oXsX+vaKeSaFWlxm4Dgq0koy6fyeqNkMlQcFZXV2gY7LqPW0i
	XII5XCOW/gETT/tmr6i2WaiG29ABZ7hAIWC497CR2Xspn+9k+C7C5e5EdGxC5jy18yQgGKVILye
	tr3CWEOrcdrUnronL/5r4xaukHKAffV0+E9wcBXsKH5jiUm+n+Ek4A7B8tjns8xTkPiqEW93F3z
	aMkGSJdYg/CqGOjDDWEtUk92z6cmpp7aNTKR4IYxB/oZ85IB9zDsJodXQOiaSfSZiKDovD2s=
X-Received: by 2002:a05:600c:8b70:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48398a4b762mr22553635e9.5.1771408926013;
        Wed, 18 Feb 2026 02:02:06 -0800 (PST)
X-Received: by 2002:a05:600c:8b70:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48398a4b762mr22553005e9.5.1771408925365;
        Wed, 18 Feb 2026 02:02:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483970ce7d2sm34659975e9.0.2026.02.18.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 02:02:04 -0800 (PST)
Date: Wed, 18 Feb 2026 11:02:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net] vsock: lock down child_ns_mode as write-once
Message-ID: <aZV6HRAIsf_rNRM2@sgarzare-redhat>
References: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259248-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,meta.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7EE515518F
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 05:45:10PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>To improve the security posture of vsock namespacing, this patch locks
>down the vsock child_ns_mode sysctl setting with a write-once policy.
>The user may write to child_ns_mode only once in each namespace, making
>changes to either local or global mode be irreversible.
>
>This avoids security breaches where a process in a local namespace may
>attempt to jailbreak into the global vsock ns space by setting
>child_ns_mode to "global", creating a new namespace, and accessing the
>global space through the new namespace.

Commit 6a997f38bdf8 ("vsock: prevent child netns mode switch from local 
to global") should avoid exactly that, so I don't get this. Can you 
elaborate more how this can happen without this patch?

I think here we should talk more about what we described in 
https://lore.kernel.org/netdev/aZNNBc390y6V09qO@sgarzare-redhat/ which 
is that two administrator processes could compete in setting 
`child_ns_mode` and end up creating a namespace with an `ns_mode` 
different from the one set in `child_ns_mode`. But I would also explain 
that this can still be detected by the process by looking at `ns_mode` 
and trying again.  With this patch, we avoid this and allow the 
namespace manager to set it once and be sure that it cannot be changed 
again.

>
>Additionally, fix the test functions that this change would otherwise
>break by adding "global-parent" and "local-parent" namespaces and using
>them as intermediaries to spawn namespaces in the given modes. This
>avoids the need to change "child_ns_mode" in the init_ns. nsenter must
>be used because ip netns unshares the mount namespace so nested "ip
>netns add" breaks exec calls from the init ns.

I'm not sure what the policy is in netdev, but I would prefer to have 
selftest changes in another patch (I think earlier in the series so as 
not to break the bisection), in order to simplify backporting (e.g. in 
CentOS Stream, to keep the backport small, I didn't backport the dozens 
of patches for selftest that we did previously).

Obviously, if it's not possible and breaks the bisection, I can safely 
skip these changes during the backport.

>
>Test run:
>
>1..25
>ok 1 vm_server_host_client
>ok 2 vm_client_host_server
>ok 3 vm_loopback
>ok 4 ns_host_vsock_ns_mode_ok
>ok 5 ns_host_vsock_child_ns_mode_ok
>ok 6 ns_global_same_cid_fails
>ok 7 ns_local_same_cid_ok
>ok 8 ns_global_local_same_cid_ok
>ok 9 ns_local_global_same_cid_ok
>ok 10 ns_diff_global_host_connect_to_global_vm_ok
>ok 11 ns_diff_global_host_connect_to_local_vm_fails
>ok 12 ns_diff_global_vm_connect_to_global_host_ok
>ok 13 ns_diff_global_vm_connect_to_local_host_fails
>ok 14 ns_diff_local_host_connect_to_local_vm_fails
>ok 15 ns_diff_local_vm_connect_to_local_host_fails
>ok 16 ns_diff_global_to_local_loopback_local_fails
>ok 17 ns_diff_local_to_global_loopback_fails
>ok 18 ns_diff_local_to_local_loopback_fails
>ok 19 ns_diff_global_to_global_loopback_ok
>ok 20 ns_same_local_loopback_ok
>ok 21 ns_same_local_host_connect_to_local_vm_ok
>ok 22 ns_same_local_vm_connect_to_local_host_ok
>ok 23 ns_delete_vm_ok
>ok 24 ns_delete_host_ok
>ok 25 ns_delete_both_ok
>SUMMARY: PASS=25 SKIP=0 FAIL=0

IMO this can be removed from the commit message, doesn't add much value 
other than say that all test passes.

>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/net/af_vsock.h                  |  6 +++++-
> include/net/netns/vsock.h               |  1 +
> net/vmw_vsock/af_vsock.c                | 10 ++++++----
> tools/testing/selftests/vsock/vmtest.sh | 35 
> +++++++++++++++------------------
> 4 files changed, 28 insertions(+), 24 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d3ff48a2fbe0..c7de33039907 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -276,10 +276,14 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
> 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
> }
>
>-static inline void vsock_net_set_child_mode(struct net *net,
>+static inline bool vsock_net_set_child_mode(struct net *net,
> 					    enum vsock_net_mode mode)
> {
>+	if (xchg(&net->vsock.child_ns_mode_locked, 1))
>+		return false;
>+
> 	WRITE_ONCE(net->vsock.child_ns_mode, mode);
>+	return true;
> }
>
> static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index b34d69a22fa8..8c855fff8039 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -17,5 +17,6 @@ struct netns_vsock {
>
> 	enum vsock_net_mode mode;
> 	enum vsock_net_mode child_ns_mode;
>+	int child_ns_mode_locked;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9880756d9eff..35e097f4fde8 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -90,14 +90,15 @@
>  *
>  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
>  *     mode, which is set at namespace creation and immutable thereafter.
>- *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
>+ *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
>  *     child namespaces will inherit when created. The initial value matches
>  *     the namespace's own ns_mode.
>  *
>  *   Changing child_ns_mode only affects newly created namespaces, not the
>  *   current namespace or existing children. A "local" namespace cannot set
>- *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
>- *   from the parent's child_ns_mode.
>+ *   child_ns_mode to "global". child_ns_mode is write-once, so that it may
>+ *   be configured and locked down by a namespace manager. At namespace
>+ *   creation, ns_mode is inherited from the parent's child_ns_mode.

We just merged commit a07c33c6f2fc ("vsock: document namespace mode 
sysctls") in the net tree, so we should update also 
Documentation/admin-guide/sysctl/net.rst

>  *
>  *   The init_net mode is "global" and cannot be modified.

Maybe we should also emphasise in the documentation and in the commit 
description that `child_ns_mode` in `init_net` also is write-once, so
writing `local` to that one by the init process (e.g. systemd), 
essentially will make all the new namespaces in `local` mode. This could 
be useful for container/namespace managers.

>  *
>@@ -2853,7 +2854,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 		    new_mode == VSOCK_NET_MODE_GLOBAL)
> 			return -EPERM;
>
>-		vsock_net_set_child_mode(net, new_mode);
>+		if (!vsock_net_set_child_mode(net, new_mode))
>+			return -EPERM;

So, if `child_ns_mode` is set to `local` but locked, writing `local` 
again will return -EPERM, is this really what we want?

I'm not sure if we can relax it a bit, but then we may race between 
reader and writer, so maybe it's fine like it is in this patch, but we 
should document better that any writes (even same value) after the first 
one will return -EPERM.

About that, should we return something different, like -EBUSY ?
Not a strong opinion, just to differentiate with the other check before.

Thanks,
Stefano


