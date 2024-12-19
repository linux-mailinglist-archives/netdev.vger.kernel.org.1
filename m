Return-Path: <netdev+bounces-153191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D019F723E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45BD1885CE5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F67081E;
	Thu, 19 Dec 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUX5yy1+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383240BE0
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572626; cv=none; b=XuZsyPlUQkpmT8oVIvsYMbj7Pq4I8LlQdpXrfMm7DCsGcDAeafHRvXskYSFjXksAzeA0rnwLKWoLvWvL3cvaN20oRA+e9+tVii3o/lA6yQQQ6X4siNKCbtYDCAZVe+GwZWzmolhfuGZxyJ6VqcuXvUtayaWTi9kdoo87bbWmKF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572626; c=relaxed/simple;
	bh=+R71dGjLQ1T8oY+6Gy8QVAIkuF+oW3XRKbWd+tMSp8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb5U7e0eX6uf1ydqltbrqjpH4hlUsbqX/ktEA/bFvC/Ny1RJ7zf+LehqN8hQo0RU+ViohIJq5i90LMp01YG+SRvvFUCUvMHsJp4OPrsoi12m6fFwG4QOS6UbF2qf9aTFGJ0jC5UQtOO/DcPcm/AEfdBkonj+1yBvCiYhUThNpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUX5yy1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72FAC4CECD;
	Thu, 19 Dec 2024 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734572626;
	bh=+R71dGjLQ1T8oY+6Gy8QVAIkuF+oW3XRKbWd+tMSp8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gUX5yy1+NP4nf29Sfy+ID1IIpMP+MB//rbPwonBwxK2zRNbg8xloBgb8OfDJ2Muyj
	 Ha3AyEhPYfnJ641WejOvv4w9+sW7hGbzy3FqSWRddMDUIXhz1I188/2c96QHzB1nMP
	 ljltEdxZ+h18CxK4WPhISSvKjh/Q7+Fxi6BeS6zNsjvxgIX5KmlQI1W2Ag9ffUCGpW
	 9z5KY79q0v/RmAqy3Wl+6XUYF++kp0ZKrkvGH2PVipqHKjSsahckInWT4fbz+43t3o
	 QOGt6WvG9Zbmy0cSCSqHGTqq3HVDzHykptvTI2jwJjLNpFIuH0XAsnwUqiXSxVywil
	 qnY55hfHrbBcw==
Date: Wed, 18 Dec 2024 17:43:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API
 for Homa
Message-ID: <20241218174345.453907db@kernel.org>
In-Reply-To: <20241217000626.2958-2-ouster@cs.stanford.edu>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
	<20241217000626.2958-2-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 16:06:14 -0800 John Ousterhout wrote:
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif

I'm not aware of any networking header wrapped in extern "C"
Let's not make this precedent?

> +/* IANA-assigned Internet Protocol number for Homa. */
> +#define IPPROTO_HOMA 146
> +
> +/**
> + * define HOMA_MAX_MESSAGE_LENGTH - Maximum bytes of payload in a Homa
> + * request or response message.
> + */
> +#define HOMA_MAX_MESSAGE_LENGTH 1000000
> +
> +/**
> + * define HOMA_BPAGE_SIZE - Number of bytes in pages used for receive
> + * buffers. Must be power of two.
> + */
> +#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
> +#define HOMA_BPAGE_SHIFT 16
> +
> +/**
> + * define HOMA_MAX_BPAGES - The largest number of bpages that will be required
> + * to store an incoming message.
> + */
> +#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) \
> +		>> HOMA_BPAGE_SHIFT)
> +
> +/**
> + * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided into
> + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
> + * for well-defined server ports. The remaining ports are used for client
> + * ports; these are allocated automatically by Homa. Port 0 is reserved.
> + */
> +#define HOMA_MIN_DEFAULT_PORT 0x8000

Not sure why but ./scripts/kernel-doc does not like this:

include/uapi/linux/homa.h:51: warning: expecting prototype for HOMA_MIN_DEFAULT_PORT - The 16(). Prototype was for HOMA_MIN_DEFAULT_PORT() instead

> +/**
> + * struct homa_sendmsg_args - Provides information needed by Homa's
> + * sendmsg; passed to sendmsg using the msg_control field.
> + */
> +struct homa_sendmsg_args {
> +	/**
> +	 * @id: (in/out) An initial value of 0 means a new request is
> +	 * being sent; nonzero means the message is a reply to the given
> +	 * id. If the message is a request, then the value is modified to
> +	 * hold the id of the new RPC.
> +	 */
> +	uint64_t id;

Please use Linux uapi types, __u64

> +	/**
> +	 * @completion_cookie: (in) Used only for request messages; will be
> +	 * returned by recvmsg when the RPC completes. Typically used to
> +	 * locate app-specific info about the RPC.
> +	 */
> +	uint64_t completion_cookie;
> +};
> +
> +#if !defined(__cplusplus)
> +_Static_assert(sizeof(struct homa_sendmsg_args) >= 16,
> +	       "homa_sendmsg_args shrunk");
> +_Static_assert(sizeof(struct homa_sendmsg_args) <= 16,
> +	       "homa_sendmsg_args grew");
> +#endif
> +
> +/**
> + * struct homa_recvmsg_args - Provides information needed by Homa's
> + * recvmsg; passed to recvmsg using the msg_control field.
> + */
> +struct homa_recvmsg_args {
> +	/**
> +	 * @id: (in/out) Initially specifies the id of the desired RPC, or 0
> +	 * if any RPC is OK; returns the actual id received.
> +	 */
> +	uint64_t id;
> +
> +	/**
> +	 * @completion_cookie: (out) If the incoming message is a response,
> +	 * this will return the completion cookie specified when the
> +	 * request was sent. For requests this will always be zero.
> +	 */
> +	uint64_t completion_cookie;
> +
> +	/**
> +	 * @flags: (in) OR-ed combination of bits that control the operation.
> +	 * See below for values.
> +	 */
> +	uint32_t flags;
> +
> +	/**
> +	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
> +	 * Passes in bpages from previous messages that can now be
> +	 * recycled; returns bpages from the new message.
> +	 */
> +	uint32_t num_bpages;
> +
> +	/**
> +	 * @bpage_offsets: (in/out) Each entry is an offset into the buffer
> +	 * region for the socket pool. When returned from recvmsg, the
> +	 * offsets indicate where fragments of the new message are stored. All
> +	 * entries but the last refer to full buffer pages (HOMA_BPAGE_SIZE
> +	 * bytes) and are bpage-aligned. The last entry may refer to a bpage
> +	 * fragment and is not necessarily aligned. The application now owns
> +	 * these bpages and must eventually return them to Homa, using
> +	 * bpage_offsets in a future recvmsg invocation.
> +	 */
> +	uint32_t bpage_offsets[HOMA_MAX_BPAGES];
> +};
> +
> +#if !defined(__cplusplus)
> +_Static_assert(sizeof(struct homa_recvmsg_args) >= 88,
> +	       "homa_recvmsg_args shrunk");
> +_Static_assert(sizeof(struct homa_recvmsg_args) <= 88,
> +	       "homa_recvmsg_args grew");
> +#endif
> +
> +/* Flag bits for homa_recvmsg_args.flags (see man page for documentation):
> + */
> +#define HOMA_RECVMSG_REQUEST       0x01
> +#define HOMA_RECVMSG_RESPONSE      0x02
> +#define HOMA_RECVMSG_NONBLOCKING   0x04
> +#define HOMA_RECVMSG_VALID_FLAGS   0x07
> +
> +/** define SO_HOMA_RCVBUF - setsockopt option for specifying buffer region. */
> +#define SO_HOMA_RCVBUF 10
> +
> +/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. */
> +struct homa_rcvbuf_args {
> +	/** @start: First byte of buffer region. */
> +	void *start;

I'm not sure if pointers are legal in uAPI.
I *think* we are supposed to use __aligned_u64, because pointers
will be different size for 32b binaries running in compat mode
on 64b kernels, or some such.

> +	/** @length: Total number of bytes available at @start. */
> +	size_t length;
> +};
> +
> +/* Meanings of the bits in Homa's flag word, which can be set using
> + * "sysctl /net/homa/flags".
> + */
> +
> +/**
> + * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism:
> + * always send all packets immediately.
> + */

Also makes kernel-doc unhappy:

include/uapi/linux/homa.h:159: warning: expecting prototype for HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism(). Prototype was for HOMA_FLAG_DONT_THROTTLE() instead

Note that next patch adds more kernel-doc warnings, you probably want
to TAL at those as well. Use

  ./scripts/kernel-doc -none -Wall $file

> +#define HOMA_FLAG_DONT_THROTTLE   2
> +
> +/* I/O control calls on Homa sockets. These are mapped into the
> + * SIOCPROTOPRIVATE range of 0x89e0 through 0x89ef.
> + */
> +
> +#define HOMAIOCFREEZE _IO(0x89, 0xef)
> +
> +#ifdef __cplusplus
> +}
> +#endif
-- 
pw-bot: cr

