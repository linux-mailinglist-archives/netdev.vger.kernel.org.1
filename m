Return-Path: <netdev+bounces-257291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBZ3GeHohGnb6QMAu9opvQ
	(envelope-from <netdev+bounces-257291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:00:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA067F6A75
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF1B302496F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A630B528;
	Thu,  5 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT/8/tKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897961DF258
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318046; cv=pass; b=Ly6S6hbHYQzhhcXYZTB1SnHQZaeFfIV+HTuPSNhjd7FKVSFjYeNN2fH7Niv2EgBX3VjzX4LzhfjhbB0tALeCra0QFztElNee2pKk0hlsTH5i2uL11fhtMQifJ//R1wy9+QwCXj4CiDgwymLOUycq1EDi9Y+IKVEoHtkKZJ2w/hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318046; c=relaxed/simple;
	bh=AuskjtNOz6nZ0G+yrh6WViA45fpVm0rg4c0PZaDjONg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK/1VhHLHvOvJ3xrNyZL+tc2GXX3jIWGJJ8DMwcGJmTolONSgzG/JYXb84hOJtfu76a58L2FIE2Tpy0rw4WzS+wRTTsAaUd5sj4PUGGGamx6G7AC62DAU0VhPe6JGWWTrM07vq8Xeh7xGfu/p2RSVpJK6TscaCy0gD3JALrNdyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT/8/tKO; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8231061d234so1366516b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770318046; cv=none;
        d=google.com; s=arc-20240605;
        b=TlfB12J3eh4+A9FlsHBQD7ziT/TvO+xCxQevIrUm1TCt4v/GJdlLPLvkD3x/ykvNhV
         4kzjdj6ob1AHtk99ZqK5jPHaQ0BqvUxBm98MJnLLzD0yxNwyKkCNuIRwGbqw7j3BuL51
         0/Zi8fS4ji2WXQYL5FaxqzkZhTcExKOsRqlhw15aUwcmEJyblT+NYkuEpm/4BIBK/uMw
         IFVoH5cVx2HybQdKSoJgFa2Q1da/53utVBZaNUGE7VhH+9hePdA6s2rGbt6es3ffcuFL
         wwN3MvHNN/goclYKFmGKy//EB0PcFmsaOGsWetAvNiGX9NiKXqpABnLhxm0d4MkyG4w3
         fF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CzWk8gLvE9O246b4A2vdYNLzmmHIUhQKe38cf0ISaC8=;
        fh=B/8sOLO1/nsEvDfP3+8lUZyZtHGloSZkIKeBh5oDmxQ=;
        b=ae/42WIEC16lUQfQz+EiC02x/xn6LhkkCA7fYOYsvmqiqqddztpDxsQ5K0DmdLIsjX
         mRM1rYJIcgg5QQSGcYe0C/7/ZVPzrKDgPNR32u/62wwLsdJrc64eEiwE+hED99gUAsw9
         bjrgqavr/j2GE/+2HPFOSp2EbWptsNwp/9H2DBaQsdMEARX2W5S2OYtZwq9+hdgXivRN
         SQUoxa1n0f7vj4HVnIiCcw5ntwDaruXlPfhYxtDBhLJXjEfn6BExnfB8Wf3wgx9z2Wa6
         JSEalmrzYnhejWQa1PyLLy/cJ8XXnjGf04KQfTsWpxBWmwqtPzBshjFsSMBUjX3huGsI
         TFeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318046; x=1770922846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzWk8gLvE9O246b4A2vdYNLzmmHIUhQKe38cf0ISaC8=;
        b=gT/8/tKOSOVMsz6n9OZMC2rrdO2BqPLRFDyZZsc+jFnSA0y3QlfPHWb0oIkvwU6G2k
         RNdfQ5Bigi6EEHo6VJNrgcT2ozHzbjniFWs+rv4e4PvyMCSPiFO61CAivsSaMEdKonOv
         PE9hnuU8lVqj4gBxcMg9vRTLp4Be2GiKJA32EENTQy9YlY8qVqb4gHc6Nsh7ETZ0uJ51
         JNT5ArXbNkdIBMRUK9kdPyw3daY/upi5v0gEt/DIdyMgYgkG3ZDIT755YPUn3Qc605w3
         54+hDQ2yta2BUNYaH53PT9wGspIGGqiUQp4eCaoanQN9+bcovFzg8Uc0r/1hSBaq7MJg
         a9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318046; x=1770922846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzWk8gLvE9O246b4A2vdYNLzmmHIUhQKe38cf0ISaC8=;
        b=Cx+E+Kg+TQS4wHcO7OD+T3B9g2f07P2E0BDkv/hFCHxr1JZ6ODWKal3icTgpoyzIDV
         mWggcRZTw999mgGhagNAgp4O03elp/6OeClto5bAa0ZmNUpvA2eYAmtdX1erdbt3RPo2
         H4qp6aw0M9a4CQv3hyCHei6QQIFtRAIWyla406QdLgBNq0NGFfQkiVxsiF2bPeTMiIkQ
         gffnfas0nnOWt9p0Zv21PdWizpyq87/YmNCXLFnBZTSpMu3+HzIpv320iubHESH70k23
         lfhOIaK75iYIKqmXWahcQRWkod9XdKPHHWt6obcTQYX5gmKvmmzHeDLllszKD4LC8Kdz
         hB0A==
X-Forwarded-Encrypted: i=1; AJvYcCXvk1pFJa4dwHy9PSrsbRMWbHRbCLqU1PzfI3gOpip67GZnuEiV0MbjTFhaZuI577h9IkiA2PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrxb1mzoCb3E+DZeE4hP75eBnKkkdrngMEHr6UOrorDDsNMyZZ
	/puFNnQqj7Adt2AnxDWXljdG07jtmCcwGZxPDHFWAx0NLLFaxzxhoUD/8dojvJa1wz1ukpqbz4p
	dItjopmWfcScx/AbTUsLJHEjYXYRCiLY=
X-Gm-Gg: AZuq6aLtokwjNJSllJmYkpXzU26FX8rYHL94SYfjlshaEtZa/hIvOhs3dWrC0eywFK8
	dPlxe4YOENeg5hlH1DDpp1Y3RVRkWmfjA2ElTHQfYigvhTNQUtOyjoDcgIfuk3RYGquqtazXO8j
	szknu+m1o2EKIEgiMUnARmDgPqQfjHqL1Fd8rIlGeNLSlsLRU+2kz3AEY/3KdMwFQp28LKqApax
	zvF6+01yR5cIO2mOrU3YGAMEh+xjeJroXSLwFqNsIKagKSJCcvWkEjZ+PwfwQyWOTOJObir8iuH
	ObjGkgGWDNJv5mdFPy70F89RHSy5
X-Received: by 2002:a05:6a00:2e07:b0:81e:711d:b26f with SMTP id
 d2e1a72fcca58-824416f7a4bmr51256b3a.43.1770318045758; Thu, 05 Feb 2026
 11:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a872188a6e4d7b39d6d6d0f6fad7e5077bce4bae.1770042461.git.lucien.xin@gmail.com>
 <20260205115532.2195345-1-horms@kernel.org>
In-Reply-To: <20260205115532.2195345-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 5 Feb 2026 14:00:34 -0500
X-Gm-Features: AZwV_QhKP_xJtDWc386RLFvCIecEAqeBpy1wdehizIZr3NTnLt_Pak2USLctFus
Message-ID: <CADvbK_cHtubdKv4PbYf0vG=3EPMrYw_Jo=_qqNvVb6+SoDvB3w@mail.gmail.com>
Subject: Re: [net-next,v9,09/15] quic: add congestion control
To: Simon Horman <horms@kernel.org>
Cc: steved@redhat.com, marcelo.leitner@gmail.com, aahringo@redhat.com, 
	alibuda@linux.alibaba.com, jbaron@akamai.com, hare@suse.de, kuba@kernel.org, 
	tom@talpey.com, linux-cifs@vger.kernel.org, daniel@haxx.se, 
	quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com, 
	dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com, 
	pc@manguebit.com, kernel-tls-handshake@lists.linux.dev, 
	illiliti@protonmail.com, xiyou.wangcong@gmail.com, 
	andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com, 
	pabeni@redhat.com, matttbe@kernel.org, netdev@vger.kernel.org, 
	smfrench@gmail.com, metze@samba.org, mbuhl@openbsd.org, 
	chuck.lever@oracle.com, dreibh@simula.no, davem@davemloft.net, 
	sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257291-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,kernel.org,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA067F6A75
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 6:55=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add congestion control
>
> This patch introduces quic_cong for RTT measurement and congestion contro=
l,
> implementing a state machine with slow start, congestion avoidance, and
> recovery phases using the New Reno algorithm.
>
> > diff --git a/net/quic/cong.c b/net/quic/cong.c
> > --- /dev/null
> > +++ b/net/quic/cong.c
>
> [ ... ]
>
> > +static int quic_cong_check_persistent_congestion(struct quic_cong *con=
g, u64 time)
> > +{
> > +     u32 ssthresh;
> > +
> > +     /* rfc9002#section-7.6.1:
> > +      *   (smoothed_rtt + max(4*rttvar, kGranularity) + max_ack_delay)=
 *
> > +      *      kPersistentCongestionThreshold
> > +      */
> > +     ssthresh =3D cong->smoothed_rtt + max(4 * cong->rttvar, QUIC_KGRA=
NULARITY);
> > +     ssthresh =3D (ssthresh + cong->max_ack_delay) * QUIC_KPERSISTENT_=
CONGESTION_THRESHOLD;
> > +     if (cong->time - time <=3D ssthresh)
> > +             return 0;
>
> [ ... ]
>
> > +/* rfc9002#section-5: Estimating the Round-Trip Time */
> > +void quic_cong_rtt_update(struct quic_cong *cong, u64 time, u32 ack_de=
lay)
> > +{
> > +     u32 adjusted_rtt, rttvar_sample;
> > +
> > +     /* Ignore RTT sample if ACK delay is suspiciously large. */
> > +     if (ack_delay > cong->max_ack_delay * 2)
> > +             return;
> > +
> > +     /* rfc9002#section-5.1: latest_rtt =3D ack_time - send_time_of_la=
rgest_acked */
> > +     cong->latest_rtt =3D cong->time - time;
>
> The field cong->time is described as "Cached current timestamp" in struct
> quic_cong, but where is it written? The socket struct is zero-initialized=
,
> so cong->time will always be 0.
>
> When computing RTT with a positive packet send timestamp in the time
> parameter, does this cause unsigned integer underflow? For example, if th=
e
> packet was sent at time 12345, computing 0 - 12345 wraps to a very large
> value.
>
> The same issue appears in quic_cong_check_persistent_congestion() where
> cong->time - time is compared against ssthresh, and in quic_reno_on_packe=
t_lost()
> and quic_reno_on_process_ecn() where recovery_time is set to cong->time.
This is not a problem, cong->time will always be set before processing
the packet on the TX path in the next patch series.

Thanks.

