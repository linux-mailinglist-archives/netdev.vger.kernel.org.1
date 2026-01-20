Return-Path: <netdev+bounces-251519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MrwGZWsb2miEwAAu9opvQ
	(envelope-from <netdev+bounces-251519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:25:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10A47740
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43EE79A9453
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BE4611D6;
	Tue, 20 Jan 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrT3A/XG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E23449ECE
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921113; cv=pass; b=YKEIeUyOdyh9JJ8IqJbKi8iiwoWaSFvsjNRYxHwky/qnovl3KxVXYZ7LpUIJhn+ZfHRS6ocaDTud5xws1H18HTTicY8FGZer2dhyACxOmnzkPXyxGzHg8g8Y0nA+qHclX4tkh1uBqKin3j7im/xm3Y365noX/l+YFhh3tJ4eSk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921113; c=relaxed/simple;
	bh=AV9hAIQr5RzI8gRTr0Om3D11rvB2xShikwoc1m16OHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO287GqGyt0i4msy69k0Jn5Mm8HUhQHrpMDi1cwR4bjPBHYxUM5ql9DGr8d1rvNQtjNuVTFLmzaoF64h80KSjKBQ+8ofysalg2KOo5V+kHdWUWbMo5IOfXcWlbPxyOnKFYITWB1ezHH/Lo3G08V+HRhBC/dy2MMtLfECHReHqfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrT3A/XG; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81345800791so3700430b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 06:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768921110; cv=none;
        d=google.com; s=arc-20240605;
        b=ErmZkMUi2pYVZZwMbX6uCU2rQ1U/NpB1yIEBkDTJMbFqwgzNE7expI5dVtwsXCUQB1
         53t9J6gCFIggfeHPvsCdV2xBT4tRVi4quIf8sFyUJDYSRxmWMptNWGoU2wh3a5QpHg8a
         tZbVEpasryxVknxA8NZcCtRgf4LKc8xu4KNGz0kf79uC0tUR1V5PZPY3Fm1Jjo3AvoFf
         GxYwa3KU9e2GPIh0MORGGE1LAkfza7uWlzfnYY8GXsXcpyAMNwGY/f5yqgyfViIWPi/t
         I+XyN7HpiVpu1KvZPd4ZvjYT+QLnFSmGELwEJPrvtn1W+4lNyUcN684kJHnQL0Ah5Mq3
         fH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EUfRwMQV3KapT7k/eehULUSMHqVaGxUA4eRrbnoBX9U=;
        fh=fDbUfIcx4Ncec9AV4wxOHXS/c8ilfxJ4Jm8OWBj8/eg=;
        b=jRnOS628yhxLRotSTNBWy/NkWnNBFzNIyxJy0IU+eObV+bHcRQlpvnYOnckqdAmUtD
         7KxRLwgskDs7jc2Qe6UbIISqN0TQQPLF7EQ0eUeWsnEP7vyUzdVObheptHmL4iNWMszX
         EgxvhBJKLdSMYhUKIdfXmxt1Fm6Xxw0ECPD+MPh7VSP5JOXPmNPTqeA7q5XUxVgLVW/D
         +uV31mSLZTC+V08mG/CuX6+QfBAl1pFtNtPw+VSo/GOJhMq99WsWvlDuQQUqj1ftCEnW
         CkBilTTibHeo5jbnmORdkLQcn2Ign6z0n9gVk2a+qT3HqMWrh/tMCaFhsUqCBD0UCmbI
         jSzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921110; x=1769525910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUfRwMQV3KapT7k/eehULUSMHqVaGxUA4eRrbnoBX9U=;
        b=VrT3A/XGeXGv/3EgNntOVwTUsGMRpoH6LR4CIPrz2kzgzQ9RkSGlwoi03OUqReXrWN
         /LnaVEUR8wStMnwYf6r2euogFv+e8OOaESrNnfb8SYV+tJh3NI4vcm0GrNjUBHliP48Y
         e1eniaPCJOOnbYCNWCtFIxRCajPUthpQxwj5PNqKbCJFzc3/ahONyuZLLuPfwjQioy1k
         Atfe0DVCpxvthof+93Ymty4ZdeLJ8hy5jV7+mXIyDvJP14o+vUHJ6ixUSavix3/5fnwW
         45BVqZfW+njhnvUS7eF4x34L5EBQifb4zsmWlCiAelWzLCyrTsmkG3SDRf2n0b4UCeK2
         j6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921110; x=1769525910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUfRwMQV3KapT7k/eehULUSMHqVaGxUA4eRrbnoBX9U=;
        b=hCuhwv/64aJJwja+OgHIi5U86R7KdJbrRS2MCrtMqW9EzmMkSZ7aWk/TWAHmfQ7aYV
         YxIWz0dIfEKvgfyruMpUfXtfLU2idPiwjwrA8ASpeUjV5qmVyzJEDndltzL30fIY/NPj
         YeRfoZO9TnI2Q1JLunke1qJa5YPkl4I5Ax6zB3hawXsV8nbkzplfuRZ5vTHnMDfMHF5g
         MRCyIiN8Tn2gHHAA08kU+shum99YTfjSc8NT5SBEOYW66a292PW5q/ZoyZ1sVLiTe0Xn
         GkyU4aYBFXZXc2czbu6ghkGPEw6cQ6DnbNt7JH2qsniwz52eFQWjDw+sZTJW0Rwk37Iz
         vwTQ==
X-Gm-Message-State: AOJu0Yznot/PjTnsIzKe4p+qb7UHrgtqELOGDiNQWMTEp+e/CU78W8yU
	YL8nJQZCrJ9Y28sjrCAJxkQtEQTFx7LBSWu6DrhtF0N3Iui0dtIPnwm3todb7QrODdXnJvMooQB
	eU+kJBP8kktQkqz+Msxpm7QEcpN+EvpE=
X-Gm-Gg: AY/fxX4+RIu3DIUb5qmTHvmX7MXHuRnoXLhSVbHh7R37hUio0fyHbB6MO7zwnovCeQt
	9ZB8oaUiySKgFgyBPlm8lklg62Fp/eRDtKiLdpSai/VTEPNkKgbM5zLxoN8h1osrVbM9nJyt1fB
	VuEs0GcC1idTy4frUNK50h0mkHa2V/Z2iT6fpHy74e6EGHf00gNOn5lQ7CgIAVgxUqULD4e2LeO
	7RtsI2i0FPz8yaWjvbqw64pE3GKE/lBwmSmlEjEB2VXZb/Dim8nS95yPIRzNTQjkQHtGsFdnZbK
	gRCaUstmqLs0XKpPf9nG6vSV4ifqWMWjI2TC+P4=
X-Received: by 2002:a05:6a21:692:b0:38d:f0f3:b940 with SMTP id
 adf61e73a8af0-38e00d47b68mr13733048637.57.1768921110331; Tue, 20 Jan 2026
 06:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768489876.git.lucien.xin@gmail.com> <e3f770ef8d9aba101e1f5dc2f2f72bb0d2a30b94.1768489876.git.lucien.xin@gmail.com>
 <6c6d5644-3354-46ba-bbc9-e76789648abf@redhat.com>
In-Reply-To: <6c6d5644-3354-46ba-bbc9-e76789648abf@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Jan 2026 09:58:18 -0500
X-Gm-Features: AZwV_Qg7dfPxOkDkqOzOQW_7YKwWAViU6i2Li95CyFWjfHPIuFun67eybDn2Dd4
Message-ID: <CADvbK_dh-O9NuNE4XL2ic2WUy9ysWc1NzbsJ99kv0ZciAw7ttQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/16] quic: add stream management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CA10A47740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/15/26 4:11 PM, Xin Long wrote:
> > +struct quic_stream {
> > +     struct hlist_node node;
> > +     s64 id;                         /* Stream ID as defined in RFC 90=
00 Section 2.1 */
> > +     struct {
> > +             /* Sending-side stream level flow control */
> > +             u64 last_max_bytes;     /* Maximum send offset advertised=
 by peer at last update */
> > +             u64 max_bytes;          /* Current maximum offset we are =
allowed to send to */
> > +             u64 bytes;              /* Bytes already sent to peer */
> > +
> > +             u32 errcode;            /* Application error code to send=
 in RESET_STREAM */
> > +             u32 frags;              /* Number of sent STREAM frames n=
ot yet acknowledged */
> > +             u8 state;               /* Send stream state, per rfc9000=
#section-3.1 */
> > +
> > +             u8 data_blocked:1;      /* True if flow control blocks se=
nding more data */
> > +             u8 done:1;              /* True if application indicated =
end of stream (FIN sent) */
>
> Minor nit: AFAICS with the current struct layout the bitfield above does
> not save any space, compared to plain u8 and will lead to worse code.
>
Makes sense, will change to plain u8.

Thanks.
> > +     } send;
> > +     struct {
> > +             /* Receiving-side stream level flow control */
> > +             u64 max_bytes;          /* Maximum offset peer is allowed=
 to send to */
> > +             u64 window;             /* Remaining receive window befor=
e advertise a new limit */
> > +             u64 bytes;              /* Bytes consumed by application =
from the stream */
> > +
> > +             u64 highest;            /* Highest received offset */
> > +             u64 offset;             /* Offset up to which data is in =
buffer or consumed */
> > +             u64 finalsz;            /* Final size of the stream if FI=
N received */
> > +
> > +             u32 frags;              /* Number of received STREAM fram=
es pending reassembly */
> > +             u8 state;               /* Receive stream state, per rfc9=
000#section-3.2 */
> > +
> > +             u8 stop_sent:1;         /* True if STOP_SENDING has been =
sent */
> > +             u8 done:1;              /* True if FIN received and final=
 size validated */
>
> ... same here...
>
> > +     } recv;
> > +};
> > +
> > +struct quic_stream_limits {
> > +     /* Stream limit parameters defined in rfc9000#section-18.2 */
> > +     u64 max_stream_data_bidi_remote;        /* initial_max_stream_dat=
a_bidi_remote */
> > +     u64 max_stream_data_bidi_local;         /* initial_max_stream_dat=
a_bidi_local */
> > +     u64 max_stream_data_uni;                /* initial_max_stream_dat=
a_uni */
> > +     u64 max_streams_bidi;                   /* initial_max_streams_bi=
di */
> > +     u64 max_streams_uni;                    /* initial_max_streams_un=
i */
> > +
> > +     s64 next_bidi_stream_id;        /* Next bidi stream ID to open or=
 accept */
> > +     s64 next_uni_stream_id;         /* Next uni stream ID to open or =
accept */
> > +     s64 max_bidi_stream_id;         /* Highest allowed bidi stream ID=
 */
> > +     s64 max_uni_stream_id;          /* Highest allowed uni stream ID =
*/
> > +     s64 active_stream_id;           /* Most recently opened stream ID=
 */
> > +
> > +     u8 bidi_blocked:1;      /* STREAMS_BLOCKED_BIDI sent, awaiting AC=
K */
> > +     u8 uni_blocked:1;       /* STREAMS_BLOCKED_UNI sent, awaiting ACK=
 */
> > +     u8 bidi_pending:1;      /* MAX_STREAMS_BIDI needs to be sent */
> > +     u8 uni_pending:1;       /* MAX_STREAMS_UNI needs to be sent */
>
> ... and here.
>
> Other than that LGTM. With the bitfield replaced with plain u8 feel free
> to add my
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

