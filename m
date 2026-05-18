Return-Path: <netdev+bounces-289060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AClNNJoOC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F556D43B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127EE310A17A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DDB47DD70;
	Mon, 18 May 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b="S0+syl/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2D3EFD14
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109092; cv=pass; b=pmtNGbfBGrqO3Ec7p5yafj2dgpexz9m+w6FWd6RlRXnwdKoDW2/tqRU9jgTG+ruM/zKUkAbEvUJYa/C6lDI1EL9LadNcKzdqx2BPGV00AiwvyGkwl0zyXBue8ZyRiePBrEfAUKdsH1yciakQ3V3Eb1RIJrlY7InHWcN49fs53R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109092; c=relaxed/simple;
	bh=Sqv2/zJbUPZhwfmVPP/6XYmsqc5O0ye1F464HbPnnZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5Cqlg/hl+jicL6z0/ufbs7WYbD0YBxS+G2GzSJVUKQnQcEIj2uis8D7eMPyaPttaQ8YlkcX6VPs4PQXNKsyu/vYMkheh/9gZq9yK2YX+DQXOWdRq935COvDNmygyuGy4HTCtkSZzr0jovEW61VRVheY1YhPx3xoQqVwig8jDDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech; spf=pass smtp.mailfrom=monogon.tech; dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b=S0+syl/4; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monogon.tech
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6324ee4040cso624857137.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109087; cv=none;
        d=google.com; s=arc-20240605;
        b=dKa16k60hK4/MR0ZiQMk/lYBcnIKYyuQIDUvPXImIcyL9l8NcB8GRW0czI9dh26euw
         h4S1diTj2e8c3xXA27OX5mPnYlAKzUIsaFMkXd9gnm7pgKjN7Ekifvkwe2z3nCMDEZa6
         CfE+XH088GjwsI3vnia5TDTkrwB//kkuL7L0mUAhIR7tpXgtV3Gac3rLB945g6ewHa67
         y1ZYat+9k4cMvyp2HI9/L1e0jtmDs6dMDFDKxEftXpcOM4sqd+J/Crtox0LuK42PemE0
         3VckL4zNFgBn0ToXNZpsaizLMpTbrhqcurWqr6vyRcDUMlvCoBOG+kUhpB/RrmAFDmZ5
         5TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        fh=Tun8gtqDQqXixB/hOS5HfcwtkuAy9UHW1AUTwtveHwo=;
        b=OUIPybE/21QKpqvSTstkt5kTMsPyB0uwAPcWF3kUxjw+NrIOC+HdRZb8SrBZFw6FqD
         lO7fXHWNlsmrbzCxFHlkjhPNYUyVIi6fZQK6bFxzqyHjjljKUymwfkCLe7xNFIK3GCk+
         NadqEGWm/r7A3ZrVXnsIrotXeQJnjzJ2lIibP7msAdCPCOeVOxfto6E8/gI9Jmvsrgzf
         X8sN/Hs9Dk7o8vXLxtvHUFzp5UcG/gFf1SH8gFV8oTa5QqhBN+tQQl1VXOg69IKq1Hx/
         NbixMTS/NpBVhdQcFOOUxsbQarGpgcyRpCfloDtu5GtdfduxcsRG9r1ZVdp6QMqlvkeV
         oLQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monogon-tech.20251104.gappssmtp.com; s=20251104; t=1779109087; x=1779713887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        b=S0+syl/4RTeNWzpfJakVAxkUEA4U38NXjBEfyHD2q9YPMDTaV32TovJ2F8M20idxHQ
         NxhA928p0mglemYFzS+cpShbZN8Lsyeu5Ate3EJk4XaEkH6aeXnE/HSiaPRFsBcOZKoA
         c29NJwbZlYBPkq0KfjBQc4av1qjHHzwn7kWVYuZxh9pxhq3r8R1vjMXS/wRLXHA9xd1D
         EKQqVuNOKDPaN5JyyYYCxhxlg0kjOE4hBBRxCxTzze797FUTAxH/UVjc1/PSc01S9f3i
         5M32NkaLc5VG4wuJVgnng18nlZYDH4rK3hoOmY74SGJEQzad24kRDTWhmpzZzOxl7mj+
         yFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109087; x=1779713887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        b=fXe3NGlgURIr/uXaQvRsq3+ADUOPekYkszC549Ge2aL5lCoqJ0PpZXQ3QK3AyXInz4
         gITE1F5kyNMCqbxgcIr+3M4Lw37ZltWs5uG6FEnLEhGUMd/LRi1TfZpb78URvmO7161L
         qboVP5GPsZjgOOBzwBekO3UiiXOkce/EzvISe38KY5PuWS7t/74OQIumRLtDNqBVpXNd
         KnJtM17li2PNTS3HQ/Ow9vEG2D34kWy4c2kQbOyuyxMCC+jL1pxEUfVKgfLSST1+I8Jn
         1rKivcpLmWommbWVUX+ryDytMu/voONXMHA1s7yoQ4/tvNoza0qB5e70FVES9Hmqyb2P
         EC+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/bX20LWeWFuuojCOMogQN9qTgg7Kr689mmWOE3ErlokxRf+wIF/xZy3fd/THdZNuEIJtVmaes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwyHA9+DhofJ5RSKwKpB51ArPoAlvPZOTMwsR73j0aJZI4ea4
	IVCDZkgocfB6xiRisJNh7FxXCcBkkCtAFuvkHD5OOt4R8eCD21V0sa1kWOqo06afluhAwFH+zjK
	0O9uBqI2AJYqg/xEJjQ+PJBJh/kBMMVH/os5YcO0vOw==
X-Gm-Gg: Acq92OF0IhWuCIKNwGSfnxaFTEnrnvjCaJlHEtz1VjzkJXicNvC8Niw45ejR5aA6P9C
	IUxj2enIZ5Iu0o8BrHiIYwYNrsmvDm2en3mXH7tfAPa3XY249VI/1NhBf57F8ddwpZt0WUuTJh7
	DmaO+IJadI8fzMIcO3JYXp3R/kLF6Hy8Fsylhim/RHrK7ayPoWyMxVZpvpKwVTfqDcNOZEIdjek
	Ibw/okDCdeF/mzyAR7nHBGP7lX0vKjKh6kqi3+qMP3iq+QDZ+P9afuCZXwdssIZZ5o/ozjdbyjh
	XtP7ZMtb8IneAJ5Yv4U6UT+Hk6QAzBUBplmT
X-Received: by 2002:a05:6102:6047:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-63a3d93b6edmr6378714137.13.1779109087067; Mon, 18 May 2026
 05:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512152658.2818805-1-lorenz@monogon.tech> <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
In-Reply-To: <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
From: Lorenz Brun <lorenz@monogon.tech>
Date: Mon, 18 May 2026 14:57:55 +0200
X-Gm-Features: AVHnY4KmAFH7SWcYKpSxBgfiVCiUuxFv1ES63sSXsCXW1j6V3gBDDffnv_CRq5o
Message-ID: <CAJMi0nQN+XB14Z81=W2reEGnax526-MB=Armx+f_miWMWUmRFw@mail.gmail.com>
Subject: Re: [PATCH] xsk: switch xdp_build_skb_from_zc() to napi_alloc_skb()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, stable@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 481F556D43B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[monogon-tech.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[monogon.tech : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289060-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenz@monogon.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[monogon-tech.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 13 May 2026 at 17:21, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Lorenz Brun <lorenz@monogon.tech>
> Date: Tue, 12 May 2026 17:26:56 +0200
>
> > xdp_build_skb_from_zc() allocated xdp->frame_sz bytes from the per-cpu
> > system_page_pool and built the skb head with napi_build_skb(). The
> > latter places skb_shared_info at the tail of the buffer, but the
> > helper sized the allocation as if the whole frame_sz were usable for
> > data. Whenever the packet plus reserved headroom approached frame_sz,
> > the head memcpy overran shinfo with packet content, corrupting
> > ->flags (SKBFL_ZEROCOPY_ENABLE) and ->nr_frags, which then drove
> > skb_copy_ubufs() off the end of frags[] on the RX path:
> >
> >   UBSAN: array-index-out-of-bounds in include/linux/skbuff.h:2541
> >   index 113 is out of range for type 'skb_frag_t [17]'
> >    skb_copy_ubufs+0x7da/0x960
> >    ip_local_deliver_finish+0xcd/0x110
> >    ice_napi_poll+0xe4/0x2a0 [ice]
> >
> > The overrun bytes come from the packet, so an on-wire sender can
> > corrupt kernel memory remotely whenever the XDP program returns
> > XDP_PASS.
> >
> > Rather than patch the sizing math, switch to the pattern used by other
> > in-tree AF_XDP zero-copy drivers like mlx5 and i40e which use
> > napi_alloc_skb() sized to the actual packet plus skb_put_data().
> > This sizes the head exactly for the data being copied, drops the
> > system_page_pool local_lock from this path, and removes the
> > structural mismatch between frame_sz and the skb head buffer. Frags
> > are allocated with alloc_page() per frag, matching the other drivers.
>
> I used napi_build_skb() + system page_pool to enable PP recycling
> improving XSk XDP_PASS performance a lot.
> Are you sure there's no other way to approach this?
>
> napi_alloc_skb() used in other drivers works, but it's sorta old
> approach which is way slower.
>
> System page_pools always allocate a full page, why can it create an skb
> prone to overruns?
>
> >
> > Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
> Thanks,
> Olek

Hi Olek

I looked at the code again. While your approach is indeed faster, it
is only faster for traffic bypassing AF_XDP, which is generally not
that relevant for performance.

More critically, it currently corrupts kernel memory and panics the
kernel very quickly when running with frame-size set to 2048, 1500
MTU, and passing received packets. To be honest, I'm not familiar
enough with the XSK subsystem to know exactly what specific sizing
assumption was violated here. By comparison, the approach taken by the
other drivers is a lot more obviously correct and works perfectly.

If you want to preserve the current approach, I'm perfectly happy with
that. However, I don't feel comfortable sending patches for it, as I
don't understand exactly what the expectations of the various data
blocks are.

AFAIK, reproduction should be fairly easy. You just need to run a TCP
connection to the receiving node (which gets passed to the kernel)
while receiving some UDP packets via AF_XDP at the same time. As
mentioned, it also needs frame-size 2048 to reproduce quickly.

I checked if I could get you an easy reproducer, but xdp-tools is
quite limited. If you want to keep your approach and can't reproduce
the panic yourself, let me know and I can see if I can synthesize a
minimal reproducer.

Regards,
Lorenz

