Return-Path: <netdev+bounces-186172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA90A9D5E3
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDCF4A62C8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B52957D1;
	Fri, 25 Apr 2025 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pao66x6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1992957D0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621436; cv=none; b=Dbp8gr5iSGBp8sL4bFB8dzeyNjNFcMSuia7FGmm6lYpBrliV1Al4TO3ryml7cAiap0GW26ULRJ7zyTfbTm0DkxgcSvleU0yOxdvEzMvVrXA2qkQ7NyA5fOvXA104cncK02/R73THzgQt9lud24NZV+5YDaElZKRwgm8dFAtfM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621436; c=relaxed/simple;
	bh=RorfabHcL+7/vyTMF4tZlnTL10uXHP2IZMhK0py71UU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XY/v2oPoW9n4WNpimGhk2sICvj1mYoDqal25AJq7ML+flQwaSaAh+F/kGp3m9ch7RxI4Z0/BtFrVi6PzoT+fOsc1b3NnZdkjsjQJgbJhmLw1/whDnHMSHToqqXpj9/OfB4F8G29xYdBoZV6AJtv51Dfts5n3A3gB2OYFZuNbnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pao66x6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0123CC4CEE4;
	Fri, 25 Apr 2025 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745621435;
	bh=RorfabHcL+7/vyTMF4tZlnTL10uXHP2IZMhK0py71UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pao66x6VfdVeo+U03sOA1m4xHQ5z+XmvIRI0b5VLEz4Z9f6iEJZzpWQh9r996w3dp
	 4qLUJOJgscA6Hop1ujjmEcfPQmodNaauqIWIDzwnM4Iuwhby06WfF4KFZldJHz+lG6
	 3jnIZUKxNlbF+BIeFe7XOo5n5kWh3t7UqUZ9pupFNF+yO0Vzw9xcd/EypkLdkHsRXi
	 3NMQ//Z1ZrhynoXmWLH/QJdN2t9PUfHcKWrP4UYHx6n4VmWY16YPGRIpm8m7c58SvQ
	 C/7q4mJNxXx6CDHI4FhmPQVIsf69XPxcPGVVrZT4PJ9lt79vZgtAOylPbZJt210F9R
	 VhSQIUu6L394g==
Date: Fri, 25 Apr 2025 15:50:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>, Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk,
 asml.silence@gmail.com, ap420073@gmail.com, dtatulea@nvidia.com,
 michael.chan@broadcom.com
Subject: Re: [RFC net-next 01/22] docs: ethtool: document that rx_buf_len
 must control payload lengths
Message-ID: <20250425155034.096b7d55@kernel.org>
In-Reply-To: <CAHS8izODBjzaXObT8+i195_Kev_N80hJ_cg4jbfzrAoADW17oQ@mail.gmail.com>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-2-kuba@kernel.org>
	<CAHS8izODBjzaXObT8+i195_Kev_N80hJ_cg4jbfzrAoADW17oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 13:08:33 -0700 Mina Almasry wrote:
> On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > @@ -971,6 +970,11 @@ completion queue size can be adjusted in the drive=
r if CQE size is modified.
> >  header / data split feature. If a received packet size is larger than =
this
> >  threshold value, header and data will be split.
> >
> > +``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks =
driver
> > +uses to receive packets. If the device uses different memory polls for=
 headers
> > +and payload this setting may control the size of the header buffers bu=
t must
> > +control the size of the payload buffers.
>=20
> FWIW I don't like the ambiguity that the setting may or may not apply
> to header buffers. AFAIU header buffers are supposed to be in the
> order of tens/hundreds of bytes while the payload buffers are 1-2
> orders of magnitude larger. Why would a driver even want this setting
> to apply for both? I would prefer this setting to apply to only
> payload buffers.

Okay, I have no strong reason to leave the ambiguity.

Converging the thread with Joe:

>> Document the semantics of the rx_buf_len ethtool ring param.
>> Clarify its meaning in case of HDS, where driver may have
>> two separate buffer pools. =20
>
> FWIW the docs added below don't explicitly mention HDS, but I
> suppose that is implied from the multiple memory pools? Not sure if
> it's worth elucidating that.

Maybe not sufficiently. Some NICs just have buffer pools for different
sized packets, but than the buffer size should be implied by the size
range?


How about:

 ``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffers driver
 uses to receive packets. If the device uses different buffer pools for
 headers and payload (due to HDS, HW-GRO etc.) this setting must
 control the size of the payload buffers.

