Return-Path: <netdev+bounces-258786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w/o8FH4UkmncqQEAu9opvQ
	(envelope-from <netdev+bounces-258786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 19:46:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BF713F731
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 19:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EEE7300764A
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95AE13E02A;
	Sun, 15 Feb 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXE4u9k2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3o8rcob"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B01FD4
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771181179; cv=none; b=PE+wPIgXgZ0Z2FOXV75vCySiBgn9CzJZtuKHfBdqw4br0DhYfbYFHjPBVv/9KmI+gz7MCcHiekd0wn20QxiGWQkQ8m/qe8MF0/bWh1R0pIWjyQQKmTn2EMhCpylOhugFsYFqD5BY5rhEwvWVCVzwN3KaCWov/VLF5hdxCw+wtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771181179; c=relaxed/simple;
	bh=SgJldzROvTJKX86D3Tu11W43ZgMqoXPcT8P+T7uzFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHpckzK3FilYaZhH0jbL6b3goeTpVTYvdZ0eCdAqPcFSWRfayrdaxJIZDJCI6AA2MnY0Wz6jkp1zqrfbmnfZx85gxLorLqEe3SnFhrh+3dVUEymBIpcAgRMTgfDMcW6sSqMDPxKGsGAlaASwHWhue91wjrG7FA48uAuw9C0BHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXE4u9k2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3o8rcob; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 15 Feb 2026 19:46:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771181170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxVjPQ89IX7QZv/haCBpH54723VQ0Wx6iNbqBas8AK8=;
	b=aXE4u9k2H9rZhFM1+3uX+vYjfWBHuTZ2nPJmYlX3KEZATCk9vOZ0Bv3W+XIPzR42qddFUV
	ayD690CBWlqtaNRCINNTfT1cKNUs2DIhFVVEIuojUmGE6rUk9SCaD73DcCC5YXzBS3U+TT
	dBb43cNI7a/4pbYSNMya+OiCYA/U6gEI56W0Zvj0hWrysBO1F+xAmm1WEqFUpBAPXNOvip
	13JCWV81SPpXkWuV6Yaf8NsP/Wv5FeJKBKKczGMdT0wS4NbXZYiRzkHfwDkpC04tjxsNHo
	k1uHoPwydZS0q91sK6pUpDWIyn+X/WvhQuquRz03Y4CpUU7M7LAnGY3I9NCBfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771181170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxVjPQ89IX7QZv/haCBpH54723VQ0Wx6iNbqBas8AK8=;
	b=W3o8rcoblkPW9GSaWYB/XETfOENvLuEIS8T6bWKmBxNgBdWjkFk0OU2srsC6KApotDu1+F
	HmRXnfA8JwgT2yDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260215184608.8dk4hemG@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1682a93525c87@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258786-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: B4BF713F731
X-Rspamd-Action: no action

On 2026-02-14 23:05:27 [-0500], Willem de Bruijn wrote:
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
> >  
> >  static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
> >  {
> > -	bool ret;
> > +	struct socket *sock;
> > +	struct file *file;
> >  
> >  	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)))
> >  		return true;
> >  
> > -	read_lock_bh(&sk->sk_callback_lock);
> > -	ret = sk->sk_socket && sk->sk_socket->file &&
> > -	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
> > -	read_unlock_bh(&sk->sk_callback_lock);
> > -	return ret;
> > +	/* The sk pointer remains valid as long as the skb is. The sk_socket and
> > +	 * file pointer may become NULL if the socket is closed. Both structures
> > +	 * (including file->cred) are RCU freed which means they can be accessed
> > +	 * within a RCU read section.
> 
> The fields are not __rcu annotated. Is this common knowledge or is
> there clear documentation of this behavior? Not disputing it, just not
> familiar with the rules around these fields.

The pointer is not RCU annotated because normally, within a syscall, the
file descriptor does not vanish and so the pointer remains valid. The
interrupt callback is an exception because we don't hold a reference on
the fd. But since the underlying data structures have a RCU lifetime we
could use it.

sock_alloc() allocates a struct socket_alloc which contains the struct
socket and struct inode (sock_alloc_inode()). This the sk_socket in
struct sock. Once you close the socket via the close syscall and the
last reference is gone then you end up in __fput(). The invoked
->release() callback is sock_close(). Here socket::file gets NULLed and
proto::release should sock_orphan() the sock where sock::sk_socket gets
NULLed (I don't see where else and packet_release() does so). The
"struct sock" remains around because the skb has a reference on.
Otherwise it would go, too.

Once that is done __fput() does dput() -> __dentry_kill() -> iput() ->
destroy_inode() which does RCU free the inode.
That means if we observe the pointer non-NULL we can use it under the
RCU rules because the inode is released via RCU. 

->file. At the end of __fput() there is file_free() which releases the
pointer. file goes to filp_cachep which is SLAB_TYPESAFE_BY_RCU. There
is a put_cred for file::f_cred before that and it does call_rcu() at the
end, too.

This is me reading the code on FRI/ SAT and double checking it with
ptp4l. I might have missed something but so far, it makes sense.

> It does seem that updates to sk_socket, in sock_orphan and
> sock_graft, are protected by sk_callback_lock.
> > +	 */
> > +	lockdep_assert_in_rcu_reader();
> 
> This function can be called from process context outside an RCU read
> side section, I think.
> 
> Such as a packet socket sending and hitting the __skb_tstamp_tx
> SCM_TSTAMP_SCHED at the top of __dev_queue_xmit.

If that is the case, then we could create a RCU read section here.

> > +	sock = READ_ONCE(sk->sk_socket);
> > +	if (!sock)
> > +		return false;
> > +	file = READ_ONCE(sock->file);
> > +	if (!file)
> > +		return false;
> > +	return file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
> >  }
> >  
> >  void skb_complete_tx_timestamp(struct sk_buff *skb,

Sebastian

