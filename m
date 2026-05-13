Return-Path: <netdev+bounces-287432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBe2J0QQBGoMDAIAu9opvQ
	(envelope-from <netdev+bounces-287432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:46:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F752DB71
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D6AB303DAFF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834C384CE0;
	Wed, 13 May 2026 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="RSd9HFcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D03264F2
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651201; cv=pass; b=DlHppmChGyMloKNkyToPmFmIJ/oIzLDt4eGdZoeKG+XuK4tu3QkEeLGdjVIlGM3yDUIwY7oesln7/LhAgmHw5HsWzDatrUhwV0RteK9bWlMNxRowQ5x74GuGZh47X5SjxrnjhWX2SAkuNsns7/fYeS/CaX9r2KJi8ellewljkDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651201; c=relaxed/simple;
	bh=o7/g7mttPLrlb+GoJKs56aVptnscLwSspSEnWOLsGoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwTGPESpa4IjXFSwwvXh/eDGekj7OhRez2DPeW0IuXKrfnPgrWa8jlcU7f6CBoKvQ8dPGUsEItcJLc/OHlT6uyxMerQ9ViSbOscw0mya+OYsasROlS5GBYyxORMYJuhluT+M+1eyYVm9r9j8Ega8+3DCb82ElDR1tF9U89juPMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=RSd9HFcf; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bab82d75fdso35209885ad.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778651198; cv=none;
        d=google.com; s=arc-20240605;
        b=Whi19ZX7KET/wzO0+LbjxgOtkuTojJt/h/XFkcVcc6MmLn2vJNxE89OxxSMdFdKJiS
         mbMH3ZrGfPrzi4Ciif45mwJp2ChwAKc3sQ5rHU0mYFijfuu0hB0Mwfw0oDXZgWjYLTEu
         sE0IVpq6D7fdvPsgxU+8q2iyKIvXQ2mDseBuQqT2VmYCz7wdLwKwUlox6sQqP+PNuDfP
         h1taWcQejwRN9kgBvNjw5rB3jzrHBkUxN7X38hitZjcV6GVLJmS1jpfQgntGvciESqkS
         MbuUIngY5G0ybAPmZfwsQNehoMnq0CDxNiaPUlN4/2UmLOrPEpwBgbSHLw3OGrHOtIT/
         1pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqlarKtvi5cQrTIPjPJ2d2vZ8uu2UEkwYzzIzo9Cu3Q=;
        fh=3sgsHCptTBxefpQDfKlLerbTxR2cvHAsUvLgWl3aFuw=;
        b=EprDfrPo1j+dWIGLlFThXfADMQnTQrmRSTWQGGBY2+jX7etiEPionKJsbQ4CLA9Hk5
         iFFQuQHSdEIfx5slvbBxTx188aK86d++qPu47MoGqS4D//6+Q6Sd5Q/Pd+MZsv+4q2IO
         kOVveFpIeSDrz3d/aJ3oohpQrQTLhNaoir8zszbUmxfXghjgKuCFc5bH/U8NR3ocOx/J
         CQEkuj6Ouqa5ckZ04wNHl6QnevMSwNsWrgWj/nADrO0ZNlPTlc6pzhLGJmBhVJ/SeTJI
         c3HClRuVwvxZVCUzGF675nqgSTjQ7lmcIA+Ore5R62khGCrT+MtmX8+gwVVKoWAp2ZL/
         l+zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778651198; x=1779255998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqlarKtvi5cQrTIPjPJ2d2vZ8uu2UEkwYzzIzo9Cu3Q=;
        b=RSd9HFcfBjO7SCyP9a35ooSl9ovtqsagr24dk+3UbvOVs7XakCnTliP6L7F4brTj/5
         U8RVLhY//TjPe8dUedxEjc/gDeQEe35A14UkhujeB5uNYw1ws3DEpKe01im2haWP9j6q
         3t5nyxMHU1J8lpYGwv1y4osmVrMXYoeuv0vmsQnCCXiRyFfT2ai32GXXH9LABnhT4kyl
         dvgvmKLFg7QuXEK0RhkeEe9Dchroy+jF74tDlry5pu+rIftN7PLZXMu2BfLYC8nz7Cwq
         /AAg3Lb4ski3t9X0O9IJGV67maEaacLeIoY8FzF5aGcjSlQTLI4zFbbeccjpdc3iTmYw
         i3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778651198; x=1779255998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqlarKtvi5cQrTIPjPJ2d2vZ8uu2UEkwYzzIzo9Cu3Q=;
        b=mR75AvNexwvVLYdtgVef+WqOkmYYXU/9A0zU9bJZwj3WPxAYyAfq0ehRjBmPEp+IWP
         IAaqwqsszKWv3YfTqumvR1WbdDytKkFwSve8BHTpDEbKz1/7+kKxV7Be9Hg2BeD8Wvzz
         IFuTtdgH8A7HAhhNfiGtsrsPFMoZ1pILtvw4QfHrLgK4ocCFHA8eZEZxP0knTyVfvYCv
         DoTn/u2Vvdcszhc4+Kwn5lZ26uM0e/T3wA+2daRhHGznOilfv0BCWqcw9k/62DSZmn57
         Ldo8uAxvatoEas73Zzc6NM1e3JqW1Yj6MpRf6u4JBy0hlYHgiFx4XR9ZxVi3UVZ1It8p
         zdYQ==
X-Gm-Message-State: AOJu0Ywe+B+mqQOOZYOa92+/FVUn8/hkDL9747Tkv92CL5M57XDkFIJn
	R2LkfHeyh9MjUs3N7WlEnd+25y9ZdbRzVfTIShEGOrCvF+r61A2M50hq1pDkQi36+FZkRqEIZge
	n87YHZpkP7mVUMU6pllBUcAyyv2ysto7wxOswuJud
X-Gm-Gg: Acq92OFFTKv+qd1TIc9VEqVyc0yNLZHkJTBmDWdG5asdKTxV2o9FdpOQMQowROkxxv9
	EU9F4L7eWI/aw8TXQ4Ho5+yRYWHTlvxyxxlsPQxYs3sJzmEDIR6jMEV6fwY4RFPndEv+PUbGpKU
	Xaz9H2BrbAEqF3uRN7xKf/GolWrOZ3pe0UWo2b1aYxHVYgrFW2/2SW0rj9GAn51rRBLuX2ZRpjf
	7zLXeK9aQCil627rxNxLW5CHpj7wDEDQzXXvodyJnVSTT2ZK9XMQ2G79O1wbBQdNYZd0NvoUnD/
	7r5QcA==
X-Received: by 2002:a17:903:1b65:b0:2b2:5099:2f3e with SMTP id
 d9443c01a7336-2bd27143bbcmr24457775ad.4.1778651198290; Tue, 12 May 2026
 22:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511071517.3013445-1-xmei5@asu.edu> <20260512104647.GK27589@horms.kernel.org>
In-Reply-To: <20260512104647.GK27589@horms.kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 12 May 2026 22:46:27 -0700
X-Gm-Features: AVHnY4IwYJ2Eh3RfIHSGL0anpkxUyiDJvGkauJwpXdEgOZFNBNu-Uoye-v2G0-8
Message-ID: <CAPpSM+Q2zz56fegUBFraBLLwQaGzDKyY5MOuFRKG7VkyyUDH-Q@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: fix NULL deref in hsr_get_node_data
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 317F752DB71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email,asu.edu:dkim];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-287432-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.043];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Thanks for pointing me to the patch. Their patch fixed the issue.

On Tue, May 12, 2026 at 3:46=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, May 11, 2026 at 12:15:17AM -0700, Xiang Mei wrote:
> > hsr_get_node_data() looks up a node's address-B port and dereferences
> > port->dev->ifindex without checking the return value of
> > hsr_port_get_hsr(), which returns NULL when no port of the requested
> > type is currently attached.
> >
> > node->addr_B_port is set by hsr_handle_sup_frame() on every supervision
> > frame but is never cleared when the corresponding slave is removed.
> > If one slave of an HSR master is unregistered while the master stays
> > alive (the other slave keeps it up), node_db entries retain a stale
> > addr_B_port. An unprivileged HSR_C_GET_NODE_STATUS query (genl op has
> > .flags =3D 0) then crashes the kernel:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017=
]
> >   RIP: 0010:hsr_get_node_data (net/hsr/hsr_framereg.c:892)
> >   Call Trace:
> >    hsr_get_node_status (net/hsr/hsr_netlink.c:366)
> >    genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
> >    genl_rcv_msg (net/netlink/genetlink.c:1209)
> >    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
> >    netlink_unicast (net/netlink/af_netlink.c:1344)
> >    netlink_sendmsg (net/netlink/af_netlink.c:1894)
> >    __sys_sendto (net/socket.c:2265)
> >
> > Default *addr_b_ifindex to -1 and only overwrite it when the port
> > lookup succeeds. The caller hsr_get_node_status() already treats
> > addr_b_ifindex =3D=3D -1 as "no address-B port" when emitting the
> > HSR_A_NODE_ADDR_B / HSR_A_ADDR_B_IFINDEX attributes, so behavior is
> > unchanged for valid setups.
> >
> > Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array=
 for slave devices.")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Hi,
>
> Thanks for your patch.  It appears to address the same issue as the
> following commit which was recently added to net.
>
> Here is the summary with links:
>   - [net] net: hsr: fix NULL pointer dereference in hsr_get_node_data()
>     https://git.kernel.org/netdev/net/c/911f54771ca9
>
> Although that code-changes there differ from this patch,
> I believe the overall logic is the same.
>
> Please consider an incremental patch if you think the commit above
> is insufficient for some reason.
>
> --
> pw-bot: changes-requested

