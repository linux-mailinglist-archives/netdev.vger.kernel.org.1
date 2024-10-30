Return-Path: <netdev+bounces-140216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECC9B58EC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0823B1C2272A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41268405FB;
	Wed, 30 Oct 2024 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="URKdCcFo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925853C14
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250221; cv=none; b=pB3rVacd+ZNw9iYV/HctzuEF0/vw4qrPoV8va9nY+Nuymr1/Jnw29JC7mim5zvakS8NJUBd6vohBs0aGAw5x+ZA2Nfp8teZoV3tjuhEUGDN42w3SHecBfmFo0sTUAxLxuJh1V5V6vSqxSQ0GyTbDA7NgQio7srVE7H//+Q45HoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250221; c=relaxed/simple;
	bh=RJvpBE5S9nxx5+G3sW9WzZfSOwWw5uzZ/mHZ88ZqlPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLyLXbbot8oGpDASJxnzl4SHsuNWXU9oF4hql1q4jwZUV1QQI2Gf8k14e7njFJMtvHytxVUbxvLUJTcQy2ebNWbAs88uJDpRTCstXrCbEEjXndJgs/UKbWYPNFf+kp9jYw+bosyspZ86gLKH88lmmZybT46q+v2t+DnJenE/5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=URKdCcFo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6dNRFzSlX3feZ30aQZAj097bOFbSH8w7kCnwdztI2NE=; b=URKdCcFogno0pYBpHiiWMSjZuT
	wtIn50fxvCGZZyC+e3OYHRFy6fe2LsrwxQQO+tYb23b8iDxazkK3GUOzMzxRtNpzZZFSvKIg5mUKJ
	+6Av2YxX4Qz8wJz7wr1e3T7Mfz9n3AVlSskvRGR/9iWNl+SNDpyb7YrzD60cqkTpx/W0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5x7Y-00Bdza-FN; Wed, 30 Oct 2024 02:03:36 +0100
Date: Wed, 30 Oct 2024 02:03:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <a109d5c6-76d6-47c5-834d-9f263f254b5c@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-12-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-12-ouster@cs.stanford.edu>

> +static int __init homa_load(void)
> +{
> +	int status;
> +
> +	pr_notice("Homa module loading\n");
> +	pr_notice("Homa structure sizes: data_header %u, seg_header %u, ack %u, peer %u, ip_hdr %u flowi %u ipv6_hdr %u, flowi6 %u tcp_sock %u homa_rpc %u sk_buff %u rcvmsg_control %u union sockaddr_in_union %u HOMA_MAX_BPAGES %u NR_CPUS %u nr_cpu_ids %u, MAX_NUMNODES %d\n",
> +		  sizeof32(struct data_header),
> +		  sizeof32(struct seg_header),
> +		  sizeof32(struct homa_ack),
> +		  sizeof32(struct homa_peer),
> +		  sizeof32(struct iphdr),
> +		  sizeof32(struct flowi),
> +		  sizeof32(struct ipv6hdr),
> +		  sizeof32(struct flowi6),
> +		  sizeof32(struct tcp_sock),
> +		  sizeof32(struct homa_rpc),
> +		  sizeof32(struct sk_buff),
> +		  sizeof32(struct homa_recvmsg_args),
> +		  sizeof32(union sockaddr_in_union),
> +		  HOMA_MAX_BPAGES,
> +		  NR_CPUS,
> +		  nr_cpu_ids,
> +		  MAX_NUMNODES);

We generally don't want kernel modules spamming the log. I would
suggest dropping these the pr_dbg(), or removing them altogether.

> +	status = proto_register(&homa_prot, 1);
> +	if (status != 0) {
> +		pr_err("proto_register failed for homa_prot: %d\n", status);
> +		goto out;
> +	}
> +	status = proto_register(&homav6_prot, 1);
> +	if (status != 0) {
> +		pr_err("proto_register failed for homav6_prot: %d\n", status);
> +		goto out;
> +	}
> +	inet_register_protosw(&homa_protosw);
> +	inet6_register_protosw(&homav6_protosw);
> +	status = inet_add_protocol(&homa_protocol, IPPROTO_HOMA);
> +	if (status != 0) {
> +		pr_err("inet_add_protocol failed in %s: %d\n", __func__,
> +		       status);
> +		goto out_cleanup;
> +	}
> +	status = inet6_add_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	if (status != 0) {
> +		pr_err("inet6_add_protocol failed in %s: %d\n",  __func__,
> +		       status);
> +		goto out_cleanup;
> +	}
> +
> +	status = homa_init(homa);
> +	if (status)
> +		goto out_cleanup;
> +
> +	timer_kthread = kthread_run(homa_timer_main, homa, "homa_timer");
> +	if (IS_ERR(timer_kthread)) {
> +		status = PTR_ERR(timer_kthread);
> +		pr_err("couldn't create homa pacer thread: error %d\n",
> +		       status);
> +		timer_kthread = NULL;
> +		goto out_cleanup;
> +	}
> +
> +	return 0;
> +
> +out_cleanup:
> +	homa_destroy(homa);
> +	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
> +	inet_unregister_protosw(&homa_protosw);
> +	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	inet6_unregister_protosw(&homav6_protosw);
> +	proto_unregister(&homa_prot);
> +	proto_unregister(&homav6_prot);
> +out:
> +	return status;
> +}
> +
> +/**
> + * homa_unload() - invoked when this module is unloaded from the Linux kernel.
> + */
> +static void __exit homa_unload(void)
> +{
> +	pr_notice("Homa module unloading\n");
> +	exiting = true;
> +
> +	if (timer_kthread)
> +		wake_up_process(timer_kthread);
> +	wait_for_completion(&timer_thread_done);
> +	homa_destroy(homa);
> +	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
> +	inet_unregister_protosw(&homa_protosw);
> +	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	inet6_unregister_protosw(&homav6_protosw);
> +	proto_unregister(&homa_prot);
> +	proto_unregister(&homav6_prot);
> +}
> +
> +module_init(homa_load);
> +module_exit(homa_unload);
> +
> +/**
> + * homa_bind() - Implements the bind system call for Homa sockets: associates
> + * a well-known service port with a socket. Unlike other AF_INET6 protocols,
> + * there is no need to invoke this system call for sockets that are only
> + * used as clients.
> + * @sock:     Socket on which the system call was invoked.
> + * @addr:    Contains the desired port number.
> + * @addr_len: Number of bytes in uaddr.
> + * Return:    0 on success, otherwise a negative errno.
> + */
> +int homa_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
> +{
> +	struct homa_sock *hsk = homa_sk(sock->sk);
> +	union sockaddr_in_union *addr_in = (union sockaddr_in_union *)addr;
> +	int port = 0;
> +
> +	if (unlikely(addr->sa_family != sock->sk->sk_family))
> +		return -EAFNOSUPPORT;
> +	if (addr_in->in6.sin6_family == AF_INET6) {
> +		if (addr_len < sizeof(struct sockaddr_in6))
> +			return -EINVAL;
> +		port = ntohs(addr_in->in4.sin_port);
> +	} else if (addr_in->in4.sin_family == AF_INET) {
> +		if (addr_len < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		port = ntohs(addr_in->in6.sin6_port);
> +	}
> +	return homa_sock_bind(homa->port_map, hsk, port);
> +}
> +
> +/**
> + * homa_close() - Invoked when close system call is invoked on a Homa socket.
> + * @sk:      Socket being closed
> + * @timeout: ??
> + */
> +void homa_close(struct sock *sk, long timeout)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +
> +	homa_sock_destroy(hsk);
> +	sk_common_release(sk);
> +}
> +
> +/**
> + * homa_shutdown() - Implements the shutdown system call for Homa sockets.
> + * @sock:    Socket to shut down.
> + * @how:     Ignored: for other sockets, can independently shut down
> + *           sending and receiving, but for Homa any shutdown will
> + *           shut down everything.
> + *
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_shutdown(struct socket *sock, int how)
> +{
> +	homa_sock_shutdown(homa_sk(sock->sk));
> +	return 0;
> +}
> +
> +/**
> + * homa_disconnect() - Invoked when disconnect system call is invoked on a
> + * Homa socket.
> + * @sk:    Socket to disconnect
> + * @flags: ??
> + *
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_disconnect(struct sock *sk, int flags)
> +{
> +	pr_warn("unimplemented disconnect invoked on Homa socket\n");
> +	return -EINVAL;

Can this be used to DoS the system, spam the log? At minimum rate
limit the message, but it might be better to just remove the message.

> +}
> +
> +/**
> + * homa_ioctl() - Implements the ioctl system call for Homa sockets.
> + * @sk:    Socket on which the system call was invoked.
> + * @cmd:   Identifier for a particular ioctl operation.
> + * @karg:  Operation-specific argument; typically the address of a block
> + *         of data in user address space.
> + *
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int homa_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	return -EINVAL;
> +}

Is this actually needed? Core code will generally test to see if the
op is not NULL before calling it.

> +/**
> + * homa_getsockopt() - Implements the getsockopt system call for Homa sockets.
> + * @sk:      Socket on which the system call was invoked.
> + * @level:   ??
> + * @optname: Identifies a particular setsockopt operation.
> + * @optval:  Address in user space where the option's value should be stored.
> + * @option:  ??.
> + * Return:   0 on success, otherwise a negative errno.
> + */
> +int homa_getsockopt(struct sock *sk, int level, int optname,
> +		    char __user *optval, int __user *option)
> +{
> +	pr_warn("unimplemented getsockopt invoked on Homa socket: level %d, optname %d\n",
> +		level, optname);

Another way to spam the log.

	Andrew

