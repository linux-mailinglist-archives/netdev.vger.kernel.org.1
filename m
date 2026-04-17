Return-Path: <netdev+bounces-279401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDLbGpl54mnh6AAAu9opvQ
	(envelope-from <netdev+bounces-279401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:19:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B641DEAC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEC7930027B4
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5534F46F;
	Fri, 17 Apr 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUP9b485"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AE35E950
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449941; cv=pass; b=XDrMDeBdn7wkJ+y4H4vU69xC6t7jx2Ty3TyfR5BrZWrPo69dO40Xn/DGv0SWNTx0JL/TWKilm4/ZlVZXsGdXXNBooXJAOz/pssMTrL1yPMlBKHJ1AIDK1G3JC2n3oie9Oy9Ad7EHK3MCp+Pyy9JKqvefU6oW2f0P2ROzdxDu8ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449941; c=relaxed/simple;
	bh=PuZLSjX8g4PpJXLEqT0BloGLVrRan7PsjhVwtmykARA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3rTJM7hb+z7irlDDV673tUX/fxM5jOGr2/xgQsOseeqbhje3mezsBaMgkgEhLrxMqqwy39rZaF3jm4d7YZp9JPjffNbvGmAgvRKFWdehdN8sikFyPeodWxKbuIJ4kPnJ333ohSehGkZOhIAEuKcmraJll+zyVZNPI6kp/Zsf3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUP9b485; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a154cc6a48so11639196d6.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 11:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776449933; cv=none;
        d=google.com; s=arc-20240605;
        b=g9huyoIOpEnEfxTRJrtHYn/JPchsftUui5MMFMy1S3CfMHFJ6b0vWpwyr2nz0QvTs9
         gWPo+JgR8ZhH+qFxQUYOXhw+J15U5aToPykg2Y833TSPvdx60R2+qJH4/5oJESfJFN3x
         /w4EpkKLBksa0FlKv2wUYsFLQCzlZLsXr4rf6ByeRBkVWIwwAzGWqQ4CFVMUdrWwHMBz
         GBe6xi7y27oZnq5wdzKCpGT3seEXhXqDr4dy1CKIsiTx7s6E/kkB++eC1hJ5JnsYM4fF
         HfKgt+KvFbQub8UDqvwOIIsf11AHWQ5sZuUBGZi1DL4X0cD97HVdxALefgauXMpFu8o+
         oDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77XZwNvEIAiO5vkECnwV+FfU6f9DeM62LoeBm16BFjk=;
        fh=VE1vTSEoajFgOsPILSj2j30kriwjA9NY7PFiwSX66z8=;
        b=Y78eE0rW86kiLk3ArAqV6TNMzY/eK7N1M2iKYavliSMRuxNauNdIbYy2eyHthDv6WK
         7AMu9UHI9l54osc6+7hCn1wdXFNM3YS19cEVE9x0SvS3OyJMOK5DwDudc5IgVe2oPtXW
         mqaImorLBvdvCzMZt+spMG/5CWPiPbPCXrPUH7nXMwiE18oQDpNQm4sPCaD4dAhNfTys
         YZNjaaUvi01+gVjt3AqMLWOKnNR/QIdMIA30ZmygO/j9ru34p0oicaeEyeTzuLPL0432
         5f7Yc3pHheL+alJTiA1y/QhUxtEiH54MJl8/sxYHpzZfrLqlFefghM+SwG004M+Wnwgx
         jKAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776449933; x=1777054733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77XZwNvEIAiO5vkECnwV+FfU6f9DeM62LoeBm16BFjk=;
        b=mUP9b485LrFRtBU+TL7UafTFPr3tNKguJwm3tO2hYzUwLPNehv9R9k8f9Xuki8yGlK
         w/z8/QbCsFWF06CB4qg5c0VzcX8XiJBOw6cOHgMnEArLF+3rv8N1saTrPWDjAhpBaaUs
         eHxhO4kGbR5KbwzW29CkWGyXsfMRpaU+5Sy/US7QSY7DCGLab12/zU92AiRtMcgeziWR
         tCEbTxc08M+BiL3vHEQPbSyTVpxq7TTILej3EiMMzt55oAtiefL9EbdzgYs2aVnP7NAZ
         pmr0HGBQ+Pmv/nGX25tr/N4kUFSc0Wp6JLpQUgrPayXuFGuIwwNKwF8VdPKLlGOaOvnM
         DRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776449933; x=1777054733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77XZwNvEIAiO5vkECnwV+FfU6f9DeM62LoeBm16BFjk=;
        b=N71+toQhxFuTipMhCj4ODNsUKCQK0soxdAKb23Hwe79C+831au9TZUnXv5kQVb4SqA
         aHPOQxV+fmdcKQkjO9fXto2jwO+G6JTaBVZbL5l+wgXDsn/EAxNtYHsLgvDvhqXWux96
         LhgV7pQ1+s8QokdzpHWg+FLHziivxKKkjdwq0jsRThZmkHCG11qYp3gQpzmYuE6VUjx6
         G/O82OJNcr64vbaJlrcVNlQ6fUcWtWPpXdGb6xQiz6ICxatDZ66qtx1ZMPCFFJsr3LDu
         YtPiXvevMJ8mPt7rv6K7mKNjkQzHyKbLctr0qe/d0h0ApUIO6lujAPuOWc2xf/3gj3h+
         KHzw==
X-Forwarded-Encrypted: i=1; AFNElJ/Kg4dcA/ovvgSGEQZT9yyq2QVgpakjZZF9U2Wf0wxuNScEwR62Vm52RI3evyB/I/sJdKHzsrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0d3xEFeIDNx6etBZQtCrUjAL+/t7+aKkEF4KqU57DFp+PG/6
	zjF5aVULHCvVpdR02e6FEOnqEXTz2QYKWjHPmSvSCpoXiI9en3sTWaCEkyFs3EYzMDVO+KrbmoP
	Z6X8/Z7eTn3f1dn63iQWT8hMZw8VKfcFqKHt+PQr8
X-Gm-Gg: AeBDieubaAL+Er0O3A2Qb3RggGxrjpKoKtM80gJ3oN1Ta0uz0AuPg1EojLV3uRXAx7t
	L3JODU4fGQHFhr9DsQE8Zt9BTAJsX801uunQp71B1RgtasBjSiFiIL8aET975AeJoeOgkLM0F0T
	UtfmAIkZR66GT/O2JjH+Cw7ri5jCHhAaQCTebl1u2ps0BGBvICDvn+Nmgdib3TKUglLq36KvVzh
	csHosas9xkeqR7fYQgnLuFsix7IABANwvqgkAhS27ex+xCK0YJIzfi1lW1s1QOra6jT+VUdRjwZ
	QDnrRWuxto7MdcEE4EP1UPyAQNhmWPITG7Wzi7rSu+5xkbglIyRL9eAOL4ZFyQdzff6tbYsDg/5
	1Q30IuysmKZQ04drg0BM=
X-Received: by 2002:a05:6214:43c2:b0:8a3:1a24:8e95 with SMTP id
 6a1803df08f44-8b0280cc0c3mr61805336d6.27.1776449932501; Fri, 17 Apr 2026
 11:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417175322.2701465-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260417175322.2701465-1-shardul.b@mpiricsoftware.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 11:18:40 -0700
X-Gm-Features: AQROBzA70tTRTYSGfSQUqexwbVKSMoHr75p0XD3MfcmyC8NE0QWdT-TxGMYn1cw
Message-ID: <CANn89i+Yug-M2HFnoz5LrffTaB4AHtC74sPKjLWA7cJ2fKF4-w@mail.gmail.com>
Subject: Re: [PATCH] net: hsr: avoid synchronize_net() in hsr_del_port() under rtnl_mutex
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, liuhangbin@gmail.com, lukma@nabladev.com, 
	acsjakub@amazon.de, kees@kernel.org, xiaoliang.yang_1@nxp.com, 
	fmancera@suse.de, linux-kernel@vger.kernel.org, janak@mpiric.us, 
	kalpan.jani@mpiricsoftware.com, Shardul Bankar <shardul.b@mpiricsoftware.com>, 
	syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,nabladev.com,amazon.de,nxp.com,suse.de,mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[netdev,f2fbf7478a35a94c8b7c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: CF2B641DEAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:53=E2=80=AFAM Shardul Bankar <shardulsb08@gmail.=
com> wrote:
>
> hsr_del_port() calls netdev_rx_handler_unregister(), which calls
> synchronize_net() while rtnl_mutex is held.  During netns teardown,
> cleanup_net() walks pernet_list and reaches default_device_exit_batch(),
> which takes rtnl_mutex and iterates devices calling
> rtnl_link_ops->dellink() for each.  For HSR this resolves to
> hsr_dellink() -> hsr_del_ports() -> hsr_del_port(), so the
> synchronize_net() call runs under rtnl_mutex.  Under contention this
> stalls other rtnl_mutex waiters long enough to trip the hung-task
> detector:
>
>   kworker cleanup_net -> default_device_exit_batch -> hsr_del_port
>     -> netdev_rx_handler_unregister -> synchronize_rcu_expedited
>     [slow, holds rtnl_mutex]

 synchronize_rcu_expedited() should be quite fast...



>   syz-executor -> ksys_unshare -> setup_net -> ip_tunnel_init_net
>     -> rtnl_lock  [blocked on rtnl_mutex]
>
> Open-code netdev_rx_handler_unregister() in hsr_del_port() without
> the synchronize_net() step.  This is safe because hsr_del_port()
> already defers the port free via kfree_rcu(port, rcu), so the
> rx_handler_data memory remains valid until an RCU grace period
> elapses naturally.  hsr_handle_frame() additionally re-validates
> rx_handler via hsr_port_get_rcu() before dereferencing
> rx_handler_data, so a reader that observes rx_handler_data =3D=3D NULL
> in the brief window between the two clears takes the NULL path and
> returns RX_HANDLER_PASS without touching the port.
>
> Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3Dcb64c22a492202ca929e18262f=
db8cb89e635c70

Signature looks like bug fixed recently in wireguard.

commit 60a25ef8dacb3566b1a8c4de00572a498e2a3bf9
Author: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date:   Tue Apr 14 17:39:44 2026 +0200

    wireguard: device: use exit_rtnl callback instead of manual
rtnl_lock in pre_exit



> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> Testing status:
>
> The hang was originally observed on 7.0-rc6 (commit 7ca6d1cfec80) with
> the syzkaller reproducer and a KASAN+LOCKDEP config.  Subsequent
> reproduction attempts with the same reproducer on current mainline did
> not retrigger this specific signature, so I could not verify the fix
> against a live reproducer.  The patch is submitted on the basis of
> code analysis.
>
>  net/hsr/hsr_slave.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index d9af9e65f72f..5e92f23fa1a5 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -239,7 +239,18 @@ void hsr_del_port(struct hsr_port *port)
>         if (port !=3D master) {
>                 netdev_update_features(master->dev);
>                 dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
> -               netdev_rx_handler_unregister(port->dev);
> +               /* Open-code netdev_rx_handler_unregister() without the
> +                * synchronize_net() step: holding rtnl_mutex across the
> +                * grace-period wait stalls other rtnl_mutex waiters long
> +                * enough to trip the hung-task detector under load.
> +                * Skipping synchronize_net() is safe because the port is
> +                * freed via kfree_rcu() below (so rx_handler_data memory
> +                * outlives any in-flight reader), and hsr_handle_frame()
> +                * re-validates rx_handler via hsr_port_get_rcu() before
> +                * dereferencing rx_handler_data.
> +                */
> +               RCU_INIT_POINTER(port->dev->rx_handler, NULL);
> +               RCU_INIT_POINTER(port->dev->rx_handler_data, NULL);
>                 if (!port->hsr->fwd_offloaded)
>                         dev_set_promiscuity(port->dev, -1);
>                 netdev_upper_dev_unlink(port->dev, master->dev);

You are saying that all netdev_rx_handler_unregister() uses are
potentially a problem.

This can not be true.

