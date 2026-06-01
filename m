Return-Path: <netdev+bounces-293789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIPWMQOXHWoXcgkAu9opvQ
	(envelope-from <netdev+bounces-293789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:28:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9E620DAE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF253006B17
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C03BA236;
	Mon,  1 Jun 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sSAUDiDC"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BA175A79;
	Mon,  1 Jun 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323710; cv=none; b=dvku+MaY8ST1l4DDkEQ7GXG6teL6HnmXSQlCnKoazmQKpllh3+JpD0JItNumPmkGFAUmNnUACL/mrIaeg8xrsshEMupGncapeOLXsuWs35J1OUiNc3/9XmJNl6HVOl5JrJjV+q68PyLq2zFktSieAnS2lLWBVm3FVLvQC646wqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323710; c=relaxed/simple;
	bh=IOcxPEHICCL51BKS06FyAFs8cw1ni6OLEKerno7YO5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9rR5cSqPpbrzNzfGjNlVgLyAj/7gIGvWp5qcItScWM+ykNrYGbaHJ7uZBBwXetbO1d1EH15MQ9QH7XEOUDNPBK8/xLPpaaHqYU8pApVhSSY++uKZ6V3ni75EBu6bBJ/RPeWO+8i1Y+MsIKvlF1ArLQYnql91QlAqm4noF81af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sSAUDiDC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=ld8GsU1c1V5Fz4U8E6o0CkhW7dY85l6LqJOFpHNFmks=; b=sSAUDiDCq5NGSHv+nC+l+qz+Vj
	lC/Gmk8HutkP0z9ZfJbS8rJEh8J7xUVl582c6HkKJVRq4S0o1oJpWTpb9fFhfz6XjIUl2HU1pMVUd
	pPDiqBOmGN+ctv5derWtH/PoW7qvNXwZEk/b4m7CxwdUB9Tl9tFYWR+pKM2taEn+TDEB7WksASSn2
	bzXvFegZfjXeVMk4ODi5RwzC5gQR3SiWB8jBNdVjy2W4FEKQUxImN/OC3wfnRXo4ZzghmUf+rg/aj
	AJy8zonYFpgJYYdUAm7eJgpZJ04D3d15Ejn3Yj2XAIqfzo/OhlX2dBWTtRviXFr6+JbTB4iSyZ5ci
	VAv81dWQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wU3WI-002Eg1-34;
	Mon, 01 Jun 2026 14:21:35 +0000
Date: Mon, 1 Jun 2026 07:21:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/6] Bluetooth: convert remaining bluetooth
 socket families to getsockopt_iter
Message-ID: <ah2GaClhUehy5ys9@gmail.com>
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
 <CABBYNZ+nvtMHcU9but5VEG891vyO=K0MF3OAGofANxzdLVmw-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+nvtMHcU9but5VEG891vyO=K0MF3OAGofANxzdLVmw-g@mail.gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293789-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,holtmann.org:email,sashiko.dev:url,msgid.link:url]
X-Rspamd-Queue-Id: 2FE9E620DAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Luiz,

On Thu, May 14, 2026 at 01:51:16PM -0400, Luiz Augusto von Dentz wrote:
> On Tue, May 12, 2026 at 7:12 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Continue the conversion to .getsockopt_iter for the Bluetooth socket
> > families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
> > small precursor that fixes a long-standing 1-byte put_user write in
> > hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.
> >
> > The riskiest change in this series is the SCO BT_CODEC conversion: it
> > is the only one that drops an open-coded ptr cursor in favour of
> > relying on iter_out advancing naturally on every copy_to_iter() call.
> > Every other socket option is a near-mechanical s/copy_to_user/
> > copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
> > codecs + capabilities and previously tracked its own write offset by
> > hand. Getting the cursor semantics wrong here would silently truncate
> > or misalign user-visible codec data.
> >
> > For more context about the motivation for this change, please check
> > commit 67fab22a7ad ("net: add getsockopt_iter callback to proto_ops")
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changes in v2:
> > - rebase the tree on top of bluetooth-next.
> > - Remove the selftest, which was mixing network and bluetooth together.
> > - Link to v1: https://patch.msgid.link/20260511-getsock_three-v1-0-1461fa8786ab@debian.org
> >
> > To: Marcel Holtmann <marcel@holtmann.org>
> > To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Cc: linux-bluetooth@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> > Breno Leitao (6):
> >       Bluetooth: hci_sock: write the full optval for getsockopt
> >       Bluetooth: hci_sock: convert to getsockopt_iter
> >       Bluetooth: ISO: convert to getsockopt_iter
> >       Bluetooth: RFCOMM: convert to getsockopt_iter
> >       Bluetooth: L2CAP: convert to getsockopt_iter
> >       Bluetooth: SCO: convert to getsockopt_iter
> >
> >  net/bluetooth/hci_sock.c    | 26 +++++++++++--------
> >  net/bluetooth/iso.c         | 27 ++++++++++----------
> >  net/bluetooth/l2cap_sock.c  | 61 +++++++++++++++++++++++++++------------------
> >  net/bluetooth/rfcomm/sock.c | 30 ++++++++++++----------
> >  net/bluetooth/sco.c         | 59 ++++++++++++++++++++++---------------------
> >  5 files changed, 114 insertions(+), 89 deletions(-)
> > ---
> > base-commit: c2f0079e8c42fd6814c8d6b1491e3ce0a0e3b3fa
> > change-id: 20260511-getsock_three-d0d7f1b2629e
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
>
> There are some comments from sashiko on this:
>
> https://sashiko.dev/#/patchset/20260512-getsock_three-v2-0-30b7b22ef14c%40debian.org
>
> Now Im not sure the truncating is actually used by our tools, but that
> sounds like it could break userspace if we don't check properly, or
> have you already done this for other socket families and it was
> considered to be ok?

You're right — to clarify, the patch changes behavior when the user
provides a short optlen, preventing the overflow that existed before:

 - Old code: put_user(opt, (u32 __user *)optval) unconditionally
   writes sizeof(*ptr) bytes regardless of optlen, so optlen < 4
   would overflow the user buffer and return 0.

 - New code: copy_to_iter() respects the optlen boundary, eliminating
   the overflow — but now a short buffer fails the strict length check
   and returns -EFAULT instead of 0.

I don't believe any legitimate userspace relies on the old overflow
behavior, though there's a theoretical risk of breakage. I'm not deeply
familiar with the Bluetooth ecosystem specifically, but, I would prefer to
avoid the buffer overflow in such case.

I've addressed a similar issue in another subsystem recently:

https://lore.kernel.org/all/20260521-fix_llc-v2-1-ab44cc09179c@debian.org/

Anyway, let me know if you need me to change it.
--breno


