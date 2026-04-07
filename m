Return-Path: <netdev+bounces-276162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLE0KBp11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5663B4F5E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7582301AF5E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21037C91E;
	Tue,  7 Apr 2026 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/kTL+SO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B8379EFF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596738; cv=pass; b=ArD+5TFeOpjgVKMUu9w9S7FHn+tyCtnEv1SQCZpyPuN9tutvVBYoFGYwzQ+CiYKIe4mmEZbL9vfDC2uJgUe01XlBSLLRWPWJoA9/Y01ODt0F1QZKVmySLhCBjIozmYFOn3lEBp9BikPOtJXtbNC1X7Xgk0TnJs9Aihkv8B6WnrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596738; c=relaxed/simple;
	bh=S6tbRAzFg3MeQeTC/AMFAR2X1AQ6Sye+eMi6WllNgqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN+x5tf9F8mc5rj+4WWLd1AkQi/1r7j+12Q8D6aL2LWTO1UjKy/fzoRunJ6ZLWza7Dc6TN13UWoAlhj9pjkMI/Ie20fjdz16FqCu+IIVfhq3A46b9yOXIsj/qbNxXc8MIvRzFupbCiK6hFCrJPUY9nM/GCKLe2R6JdCE0GEiPxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/kTL+SO; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a068db9989so3269076d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775596735; cv=none;
        d=google.com; s=arc-20240605;
        b=XEzu8NBrdrZF5DEzP1acw3MLz3gxhR4JG36qYisjkIWSguRrn+DE4XfZKgpVhi+NHb
         zdGak00mOxxDCAeiwKb/7DCNpuRaa6yVl+27+IDcdnxlC6UpDj052/GYMk2SGiljYBMr
         R66yY5MxX9TJiydVoMucKTRmzt/zYKxjJVLOozHp/tVd3Qd60xF7j0zYJQKAy93HpRP5
         egRhJSsnzczM1DJ2krZ2iX067Q9zr5fffn4JbDHYBt72gjgT1kqurN7KDJ6vENUnnVH6
         WErIfO55JRwPnxKne/Xrwy09HqGukx+OBXQYds4duO16IT7knFs8j1Or3aTRRDCI9xB/
         NHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AtDfCZKTY+IaeLMBmY9EmFTthg85aBiWG8xwPx5A83A=;
        fh=AKmLvzpCeypwqrnz7zc7SK/OiWvr6e4O6itO4lkKAak=;
        b=cX4RO+cga9med9yRuMJtbsiiBjTHQzk9DbKAkSMNdtUm1HatljOMUJ9XXC26iQ8jqq
         2FAN15IiDKkpDNC91av+OTJrDOpxvlBKgGdO3hE7Bp3Cs+ArHcq4bGEl5o7L13szQjCT
         uueqTqgORMH+7oYRYYcmIw6kSvulqErZf9H7CSBGgXGOo4viemBficS2ObDdXlpPSuN7
         a+zBu7e3z0T5/CTW9flt6zumQM/v2gll5j+N3Bz9ce7hw6b/jb+FLlu72qThyjLWLtqA
         P78X5EC349HM6t4x7rqnB9n6zWPlkGWFPHBHHo8qUGNL5B8woIwkgDkPBRx39IyrlIU/
         1q2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775596735; x=1776201535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtDfCZKTY+IaeLMBmY9EmFTthg85aBiWG8xwPx5A83A=;
        b=G/kTL+SOOQrXHk0FC7iGqO/k/oO7jzxosL2IV/yD2jnRsS5Mtpi5yzmpIA+LN8V1p0
         r808Wv4sWSlt+paWCn+7lvOpqd5CqOd6BP7sGrWfTn3vmF8LnwJuzckWup13xjgDEghD
         DbCCitPlEeDewcJe7RydJePtLFbp/e3PMNcoJpwZl64vbcv7aYKLYFys1oddw7s4/IzA
         XMtHbgYmi48HdUDtr8uwVDdstf56O1zIcpoB669ag+AL6KaQDtpHmycxsf8KYYbrwka7
         lFfN4JOkmj6h+7/Frl+BwhFzzPBZkeSrsUO7F+7/hI24PNZDeMlq1oQXpqlwGC6GneE4
         HbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596735; x=1776201535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtDfCZKTY+IaeLMBmY9EmFTthg85aBiWG8xwPx5A83A=;
        b=ZaBGqWQaYZOyc1foPbSRHUOOwgCnH40X9GWP4/WCPafTZ/O7jvw9sqTLx+uqF7EVrg
         b/JYkFSzIDhHKObnFkjCV9BxxiQEjUnD2WbxBsRAqVq/IB/Eb3JcnidOtGoCfci6zQ06
         Xw5W8hG8sPJMk9JOWdtR27oLbW4zc4T5CLKYCIoWT0qmMKC4SOrPhxDZkA5bNilXGnz5
         +m93eiyUTM45iPfybrFQmtq6v/dH1Xiwrkaj7E+Q5+mF90yX+yjUjC38poDb3agNOT53
         +wxiNW1OwIMX+Ybkm++ivZZzkgTn1DS3nZjr9UKc0+xiP7b1+OmKp62wLQeG9b8GBD/w
         YjHw==
X-Forwarded-Encrypted: i=1; AJvYcCWXJ+N0CfvIqanO+9GtNRk3wNEAbNIfERugi4xbfZ8XA5ZkeJc9KJeNO+1tI4Lx487wYfVA+/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUACmixKFiVSIfCTF3UefoYxfOhfk6OG3ed3P1NhoDCE6DY3m
	awM+EHll6NmurCQZEcD577ypdijbzJGw5YxEpKSSobU4DiBfXVPKVd9D9ACX1ehnCcwXAsiZCIe
	QkdvFNMavbGQbWTEIK1Vf7nUyDkUmUyU=
X-Gm-Gg: AeBDiev0ujjeMJTerHx4o5hYVF2HejdXh8pkRF0EhCSdzFdLEZ1HIqTFT3zZJwe+koL
	K39R140570Wh6F57GtMxuBrN1FRv5tflwLklLtTn3KxFjBnykMx/UIANrTM8sn0zcOn7Nqh7aYD
	wkEdx+N1XdYmyIDl/qmQj33T+jhZ7kDWV2ekPqCXLWgKLnvmTCkCyliuVDzYAafk7nsDRnCBC7c
	OT2uSH8c5OkIOqFHdCzdG/TmCw5IzSP25cBfVbr0xkAOQ0qmYNd94ne905e8m+hxvnvuydi7iK1
	nrozERNAmjmcNxd5Moe/BO4orkUQedcMV7C6PS06uCkhpWWpOxgiRyerhf7ll0QP03TR7RVPePz
	cGbtYjjXDGhclFmz0P9YHePP+HgyV+sKgA90m5oWcjJSQdqr2lnCuacGXjJgDHt0=
X-Received: by 2002:ad4:5ce8:0:b0:89c:4bba:1a93 with SMTP id
 6a1803df08f44-8a703365784mr253792856d6.5.1775596735345; Tue, 07 Apr 2026
 14:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775571957.git.metze@samba.org>
In-Reply-To: <cover.1775571957.git.metze@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 7 Apr 2026 16:18:44 -0500
X-Gm-Features: AQROBzB6Yld8UuN4npSuWr9ACQ2pYlmn8Fwib8wPVlNW8GVvQnEYxNySzkbOOyc
Message-ID: <CAH2r5mvR_ZVaNKVC+5Y-g-UZkH3FAbV39U28Pz2MjUUSVUNnMQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] smb: add kernel internal IPPROTO_SMBDIRECT
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, David Howells <dhowells@redhat.com>, 
	Henrique Carvalho <henrique.carvalho@suse.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	Xin Long <lucien.xin@gmail.com>, quic@lists.linux.dev, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276162-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,talpey.com,microsoft.com,kernel.org,redhat.com,suse.com,davemloft.net,google.com,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samba.org:email,samba.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E5663B4F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

merged the first 4 into smb3-kernel ksmbd-for-next

On Tue, Apr 7, 2026 at 9:47=E2=80=AFAM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Hi,
>
> as the work to unify the smbdirect code
> between cifs.ko and ksmbd.ko into an smbdirect.ko
> is in linux-next for a while this is the next
> step to also share the code with userspace
> e.g. Samba as client and server.
>
> The SMBDIRECT protocol, defined in [MS-SMBD] by Microsoft.
> It is used as wrapper around RDMA in order to provide a transport for SMB=
3,
> but Microsoft also uses it as transport for other protocols.
>
> SMBDIRECT works over Infiniband, RoCE and iWarp.  RoCEv2 is based on IP/U=
DP
> and iWarp is based on IP/TCP, so these use IP addresses natively.
> Infiniband and RoCEv1 require IPOIB in order to be used for SMBDIRECT.
>
> So instead of adding a PF_SMBDIRECT, which would only use AF_INET[6],
> we use IPPROTO_SMBDIRECT instead, this uses a number not
> allocated from IANA, as it would not appear in an IP header.
>
> This is similar to IPPROTO_SMC, IPPROTO_MPTCP and IPPROTO_QUIC,
> which are linux specific values for the socket() syscall.
>
>   socket(AF_INET, SOCK_STREAM, IPPROTO_SMBDIRECT);
>   socket(AF_INET6, SOCK_STREAM, IPPROTO_SMBDIRECT);
>
> This will allow the existing smbdirect code used by
> cifs.ko and ksmbd.ko to be moved behind the socket layer [1],
> so that there's less special handling. Only sock_sendmsg()
> sock_recvmsg() are used, so that the main stream handling
> is done all the same for tcp, smbdirect and later also quic.
>
> The special RDMA read/write handling will be via direct
> function calls as they are currently done for the in kernel
> consumers.
>
> As a start __sock_create(kern=3D0)/sk->sk_kern_sock =3D=3D 0 will
> still cause a -EPROTONOSUPPORT. So only in kernel consumers
> will be supported for now.
>
> For now the core smbdirect code still supports both
> modes, direct calls in indirect via the socket layer.
> The core code uses if (sc->sk.sk_family) as indication
> for the new socket mode. Once cifs.ko and ksmbd.ko
> are converted we can remove the old mode slowly,
> but I'll deferr that to a future patchset.
>
> There's still a way to go in order to make this
> as generic as tcp and quic e.g. adding MSG_SPLICE_PAGES support or
> splice_read/read_sock/read_skb.
>
> But it's a good start, which will make changes much easier.
>
> This patchset is based on top of the smbdirect.ko patches
> in ksmbd-for-next and it's also based on netdev-next
> because it needs this commit from there:
> 8341c989ac77d712c7d6e2bce29e8a4bcb2eeae4
> "net: remove addr_len argument of recvmsg() handlers"
>
> Patches 1-4 are some preparation fixes for the
> existing smbdirect.ko patchset. We may
> squash them into the existing patches before
> sending them to Linus. But for now I kept
> them separately. I also don't cc the network and rdma
> people on these...
>
> Patch 5 defines IPPROTO_SMBDIRECT and SOL_SMBDIRECT
> constants (and also reserve the number 288 for SOL_QUIC
> as applications are already using that and we don't
> want to conflict)
>
> Patch 6 adds basic IPPROTO_SMBDIRECT layering
> on top of the existing smbdirect code.
> This is just enough in order to let cifs.ko
> and ksmbd.ko use it in the following commits,
> so userspace still sees -EPROTONOSUPPORT.
>
> Patch 7 converts cifs.ko to use IPPROTO_SMBDIRECT
> as much as currently possible.
> Using sock_sendmsg is not yet possible, because of the
> tcp_sock_set_cork usage, but that will change in future.
>
> Patch 8 converts ksmbd.ko to use IPPROTO_SMBDIRECT.
>
> Because of the need for netdev-next commit
> 8341c989ac77d712c7d6e2bce29e8a4bcb2eeae4
> "net: remove addr_len argument of recvmsg() handlers"
> it's a bit tricky to prepare something that would not
> cause problems in linux-next.
>
> We could merge in netdev-next completely,
> but I saw commit 00f03539e3d97af925abf42992d8c46167d54243
> in next-20260406, indicates some resolved conflicts
> with (at least) the rdma tree, which comes
> just before netdev-next, while ksmbd-for-next is merged
> before all of them. So merging netdev-next into
> ksmbd-for-next changes the order of netdev-next vs. rdma.
>
> Or we add a new branch smbdirect-for-next that's
> merged into linux-next after netdev-next.
>
> Or a bit hacky but likely easier, ksmbd-for-next
> just cherry-picks 8341c989ac77d712c7d6e2bce29e8a4bcb2eeae4
> "net: remove addr_len argument of recvmsg() handlers"
> and that cherry picked commit is reverted as
> last commit in ksmbd-for-next, or only in linux-next
> right before netdev-next is merged.
>
> For now I have the patches in a branch with a
> cherry picked version of the needed commit only, see
> for-7.1/ipproto-smbdirect-20260407-v1 at commit:
> e1972e6f1fda9842c5724b7daf4a2aa7779901a5
> git fetch https://git.samba.org/metze/linux/wip.git for-7.1/ipproto-smbdi=
rect-20260407-v1
> https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dshortlog;h=3Drefs/head=
s/for-7.1/ipproto-smbdirect-20260407-v1
>
> It would be great to get this somehow into linux-next soon :-)
>
> Stefan Metzmacher (8):
>   smb: smbdirect: change
>     smbdirect_socket_parameters.{initiator_depth,responder_resources} to
>     __u16
>   smb: smbdirect: fix copyright header of smbdirect.h
>   smb: smbdirect: fix the logic in smbdirect_socket_destroy_sync()
>     without an error
>   smb: smbdirect: let smbdirect_connection_deregister_mr_io unlock while
>     waiting
>   net: define IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants
>   smb: smbdirect: add in kernel only support for IPPROTO_SMBDIRECT
>   smb: client: make use of IPPROTO_SMBDIRECT sockets
>   smb: server: make use of IPPROTO_SMBDIRECT sockets
>
>  fs/smb/client/cifs_debug.c                    |    2 +-
>  fs/smb/client/cifsfs.c                        |    2 +-
>  fs/smb/client/cifsglob.h                      |    7 +-
>  fs/smb/client/connect.c                       |  123 +-
>  fs/smb/client/file.c                          |    8 +-
>  fs/smb/client/sess.c                          |    4 +-
>  fs/smb/client/smb2ops.c                       |    8 +-
>  fs/smb/client/smb2pdu.c                       |   10 +-
>  fs/smb/client/smbdirect.c                     |  275 +--
>  fs/smb/client/smbdirect.h                     |   27 +-
>  fs/smb/client/transport.c                     |    2 +-
>  fs/smb/common/smbdirect/Makefile              |    1 +
>  fs/smb/common/smbdirect/smbdirect.h           |   69 +-
>  fs/smb/common/smbdirect/smbdirect_accept.c    |   14 +-
>  .../common/smbdirect/smbdirect_connection.c   |   58 +
>  fs/smb/common/smbdirect/smbdirect_devices.c   |    2 +-
>  fs/smb/common/smbdirect/smbdirect_internal.h  |   59 +-
>  fs/smb/common/smbdirect/smbdirect_listen.c    |   49 +-
>  fs/smb/common/smbdirect/smbdirect_main.c      |   45 +
>  fs/smb/common/smbdirect/smbdirect_mr.c        |   18 +
>  fs/smb/common/smbdirect/smbdirect_proto.c     | 1549 +++++++++++++++++
>  fs/smb/common/smbdirect/smbdirect_public.h    |    3 +
>  fs/smb/common/smbdirect/smbdirect_rw.c        |   29 +-
>  fs/smb/common/smbdirect/smbdirect_socket.c    |  180 +-
>  fs/smb/common/smbdirect/smbdirect_socket.h    |   26 +-
>  fs/smb/server/transport_rdma.c                |  119 +-
>  include/linux/socket.h                        |    2 +
>  include/uapi/linux/in.h                       |    2 +
>  28 files changed, 2320 insertions(+), 373 deletions(-)
>  create mode 100644 fs/smb/common/smbdirect/smbdirect_proto.c
>
> --
> 2.43.0
>


--=20
Thanks,

Steve

