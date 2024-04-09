Return-Path: <netdev+bounces-86302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE189E5A8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456B11F214AA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2771E491;
	Tue,  9 Apr 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAUZwzRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935D53AC
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701972; cv=none; b=VRRxZe72MTzbFkxXoV4nY3T92Ew2dAttuejvVW9wKxkDhJvtSVMioBanTJUuExgF3noYUxEvTMWhQCLU+hL2A6RgGmilirbHyhuo5waOgN+dPrT4EC1Eb62Ia9dBGv+Br9TpjrYx6pZuLkoWW9UzVjFi/61Ht6fw2BaF8PJ9ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701972; c=relaxed/simple;
	bh=c4cjPjLWaCzZqqaTZQprfkIjGsPSOUdjWAE62CvySgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8DlYivOd0ukTcvQLts6+wGCylcdIzw5ALVaftK/mfmTCs0Ei28BVXU4Am02J4MP+Gtc3bp+EV4dR/wOZM/yCB0Ygjz5gp3D9MrsZDp3PmMbJAwrcM1ncXk7iyO0dEeZl/Rnq7UZxTaCel7BEBpVreugivETOKFIxjkc+EQJgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAUZwzRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF15C433F1;
	Tue,  9 Apr 2024 22:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712701972;
	bh=c4cjPjLWaCzZqqaTZQprfkIjGsPSOUdjWAE62CvySgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cAUZwzRqaesXN9GHZnY0RMkw0wyhTBby3Pc+HlocWqMUO3k07jmB9UgaPZELbNXQ9
	 KwWpVtz25CgQ/GqpgzuVpFubq3kKL1pNuFiw/l/3WiJPb1nBW0WbAjfF1fQusxwimG
	 /K+3uJqzBJTsiDptR7gu+XhqVgqRo4DCqtOLRWmCu539+65TGH3mmuOkBH7e8Y+N57
	 8D4I0iBZVc6TjKmV91EKd7W2vEcQVLF9piLvdCNIm7gnVsF/b4xwmYPwm2sO2K1yMw
	 0X1P8teKI772Luq2lNJYPJe0sBhGxvu7M5lmDb8t7HPJmEkj6lD3wfpHJwnpKUF23n
	 DYLq4bQN5sfTw==
Date: Tue, 9 Apr 2024 15:32:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
Message-ID: <20240409153250.574369e4@kernel.org>
In-Reply-To: <20240405102313.GA310894@kernel.org>
References: <20240405102313.GA310894@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 11:23:13 +0100 Simon Horman wrote:
> /**
>  * enum shaper_lookup_mode - Lookup method used to access a shaper
>  * @SHAPER_LOOKUP_BY_PORT: The root shaper for the whole H/W, @id is unus=
ed
>  * @SHAPER_LOOKUP_BY_NETDEV: The main shaper for the given network device,
>  *                           @id is unused
>  * @SHAPER_LOOKUP_BY_VF: @id is a virtual function number.
>  * @SHAPER_LOOKUP_BY_QUEUE: @id is a queue identifier.
>  * @SHAPER_LOOKUP_BY_TREE_ID: @id is the unique shaper identifier inside =
the
>  *                            shaper hierarchy as in shaper_info.id
>  *
>  * SHAPER_LOOKUP_BY_PORT and SHAPER_LOOKUP_BY_VF, SHAPER_LOOKUP_BY_TREE_I=
D are
>  * only available on PF devices, usually inside the host/hypervisor.
>  * SHAPER_LOOKUP_BY_NETDEV is available on both PFs and VFs devices, but
>  * only if the latter are privileged ones.

The privileged part is an implementation limitation. Limiting oneself
or subqueues should not require elevated privileges, in principle,
right?

>  * The same shaper can be reached with different lookup mode/id pairs,
>  * mapping network visible objects (devices, VFs, queues) to the scheduler
>  * hierarchy and vice-versa.

:o

> enum shaper_lookup_mode {
>     SHAPER_LOOKUP_BY_PORT,
>     SHAPER_LOOKUP_BY_NETDEV,
>     SHAPER_LOOKUP_BY_VF,
>     SHAPER_LOOKUP_BY_QUEUE,
>     SHAPER_LOOKUP_BY_TREE_ID,

Two questions.

1) are these looking up real nodes or some special kind of node which
can't have settings assigned directly? IOW if I want to rate limit=20
the port do I get + set the port object or create a node above it and
link it up?

Or do those special nodes not exit implicitly (from the example it
seems like they do?)

2) the objects themselves seem rather different. I'm guessing we need
port/netdev/vf because either some users don't want to use switchdev
(vf =3D repr netdev) or drivers don't implement it "correctly" (port !=3D
netdev?!)?

Also feels like some of these are root nodes, some are leaf nodes?

> };
>=20
>=20
> /**
>  * struct shaper_ops - Operations on shaper hierarchy
>  * @get: Access the specified shaper.
>  * @set: Modify the specifier shaper.
>  * @move: Move the specifier shaper inside the hierarchy.
>  * @add: Add a shaper inside the shaper hierarchy.
>  * @delete: Delete the specified shaper .
>  *
>  * The netdevice exposes a pointer to these ops.
>  *
>  * It=E2=80=99s up to the driver or firmware to create the default shaper=
s hierarchy,
>  * according to the H/W capabilities.
>  */
> struct shaper_ops {
> 	/* get - Fetch the specified shaper, if it exists
> 	 * @dev: Netdevice to operate on.
> 	 * @lookup_mode: How to perform the shaper lookup
> 	 * @id: ID of the specified shaper,
> 	 *      relative to the specified @lookup_mode.
> 	 * @shaper: Object to return shaper.
> 	 * @extack: Netlink extended ACK for reporting errors.
> 	 *
> 	 * Multiple placement domain/id pairs can refer to the same shaper.
> 	 * And multiple entities (e.g. VF and PF) can try to access the same
> 	 * shaper concurrently.
> 	 *
> 	 * Values of @id depend on the @access_type:
> 	 * * If @access_type is SHAPER_LOOKUP_BY_PORT or
> 	 *   SHAPER_LOOKUP_BY_NETDEV, then @placement_id is unused.
> 	 * * If @access_type is SHAPER_LOOKUP_BY_VF,
> 	 *   then @id is a virtual function number, relative to @dev
> 	 *   which should be phisical function
> 	 * * If @access_type is SHAPER_LOOKUP_BY_QUEUE,
> 	 *   Then @id represents the queue number, relative to @dev
> 	 * * If @access_type is SHAPER_LOOKUP_BY_TREE_ID,
> 	 *   then @id is a @shaper_info.id and any shaper inside the
> 	 *   hierarcy can be accessed directly.
> 	 *
> 	 * Return:
> 	 * * %0 - Success
> 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> 	 *		    or core for any reason. @extack should be set
> 	 *		    to text describing the reason.
> 	 * * Other negative error value on failure.
> 	 */
> 	int (*get)(struct net_device *dev,
> 		   enum shaper_lookup_mode lookup_mode, u32 id,
>                    struct shaper_info *shaper, struct netlink_ext_ack *ex=
tack);

How about we store the hierarchy in the core?
Assume core has the source of truth, no need to get?

