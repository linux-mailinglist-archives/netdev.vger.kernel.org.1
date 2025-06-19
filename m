Return-Path: <netdev+bounces-199535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210AFAE0A41
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1143A3D28
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD986221286;
	Thu, 19 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp7wTtN8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526E1B3923
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346545; cv=none; b=hGc/1on1jdwN3E/znJTCeJrQ5dSHDpVD7Rw4IM0upeMGPh68jDDYJdWiZKtP/VmCUwLqdHC7rbdXoiACHxyoB7U16iQplVfFYXN2fczH4EYajAI/ooCgBMkclQqdjrPs98Bc+mhqTwbQuDbP7q1/aN3iU3aHlbWgn5fatnDb6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346545; c=relaxed/simple;
	bh=BN3GgczSv2lTIzEj5cHhjpGcDj3xSEkJ7mCFeDy5TTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gym2iuRztmfb6FyLEluRG3TskSHciqB2ZX2Lc73UAA/rZpB3qL0hRrt5Ph9cd3fNxaQzZp9T0qzRhmDKdzqmAIVAVyqqxWWA3vYU36wQHt0qsod2X6SjSVU5jOrPoAicSYQKJQXm9pJqBtH/095tRt7K0ksT3A3598HGY0C4sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp7wTtN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C80C4CEEA;
	Thu, 19 Jun 2025 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346545;
	bh=BN3GgczSv2lTIzEj5cHhjpGcDj3xSEkJ7mCFeDy5TTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kp7wTtN80nQ56YlGr1Nl1Ckf7093imjD5DyVmGNNr7dIE3gKDz35ZDP3aNCFSlAWh
	 WNxeAVoKLVoGLDWgLh5ONMwbi6JiffQ2Os+o/PEcpa4RojT1lNJ9sj3D7IOPSA5R3G
	 sBjOSSu0ZM5S4iefza8gAuUkZkEuqv09KEMfZ4pEp8YkMlMCYUo+bHXgNqmMJd65IM
	 WyJr19qtY8P79kla6rKQwAiuHC0pQfgnMXukB8dAlzCe58qjwieQ6YLvRBFfzOhBav
	 o/mHR6+W322uQoXTJfjCXTbwBD123EPEVmV5wixbqlXI0WfNJfTf/4Cg2Y2y7zP94G
	 zoV9wzumlgIFQ==
Date: Thu, 19 Jun 2025 08:22:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 net-next 1/8] virtio: introduce extended features
Message-ID: <20250619082223.58cb938c@kernel.org>
In-Reply-To: <691c3a35-45da-47f7-88fe-5679805fa6e9@redhat.com>
References: <cover.1750176076.git.pabeni@redhat.com>
	<2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
	<20250618191440.0361c343@kernel.org>
	<691c3a35-45da-47f7-88fe-5679805fa6e9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 16:36:57 +0200 Paolo Abeni wrote:
> On 6/19/25 4:14 AM, Jakub Kicinski wrote:
> > On Tue, 17 Jun 2025 18:12:08 +0200 Paolo Abeni wrote:  
> >> -	u64 features;
> >> +	VIRTIO_DECLARE_FEATURES(features);  
> > 
> > FWIW this makes kdoc upset. There is a list of regexps in
> > scripts/kernel-doc.pl which make it understand the declaration macros.
> > I think VIRTIO_DECLARE_FEATURES() needs to be added to that list.  
> 
> I guess the preferred course of action is sharing a v5 including a
> scripts/kernel-doc.pl patch, right?

Not a hard ask, but yes that'd be preferable. Unfortunately kdoc build
issues gate passing the patches to selftest stage as they often cause
htmldoc build issues as well.

