Return-Path: <netdev+bounces-186800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A62AA1303
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30EE7B39E9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED42459C9;
	Tue, 29 Apr 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDAuJJJ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD57E110
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946100; cv=none; b=G3QAOoBPEme2u/1ctGGXRVz7YnpCdmbJqXhZa8E0yUtu0yQe4a1I7tSIEshoOZbNGYuOk3LBRpHI5o7/ftRmDgtkWAEHBkTPO+rKfZsLmdVdKErO2ljRlKk9zkGT+AV2wC737tNmv0PUbZeJiaOb/8Pk2kXb+grpYCSvO8g5o7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946100; c=relaxed/simple;
	bh=xMeHUOM8Amp8g7lHgn3J5XDoc1S22zLXow+jI3sI3Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cf9ful1yxFyU8z4p5ph8HLwl+u9I+kWnlQefTnRamf5P/HRu3uXanXTqtjQKpOYg1vIVIcb/8Wuxvp+XICkenVr7IoUjzH3nLhDJYMJn49laO1GDenoRMwn8rM22gViuMcNpi8B9IlvFUaHe1K2bHAYvz8a3r+fsR0fR2hD9PUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDAuJJJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40D2C4CEEA;
	Tue, 29 Apr 2025 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745946100;
	bh=xMeHUOM8Amp8g7lHgn3J5XDoc1S22zLXow+jI3sI3Ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDAuJJJ7z0MQHwaL9eoDq+dE5icMQzWbTAddhDU232tjI7wOa65C+NrnHF1NQbcuo
	 ZDvCQQdtxssMQcVnfLU4XspXTcn0rqDQABc0o0ifmeqWewpw7pvic75i4HF/rGDMg3
	 5HNkrgkIwxI1ogXputuIknQHs/tKHyjtMX8/nRei6RI44vWbErGoYin/5qdHJKu5Ak
	 2GmpVNjEilLMxEFoOiQYWLTV5mepB77a4bG7ZqOe0h66LH/LR5ppmZGhvrDFMIop9/
	 5CFTRMwhSLJDStbxVf/coIGnssAoheEiSggGJ71g0qGLtC+/noq6Pfct/838EdEzq7
	 U9e8eqylFGRPg==
Date: Tue, 29 Apr 2025 10:01:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 02/15] devlink: define enum for attr types
 of dynamic attributes
Message-ID: <20250429100138.0454967a@kernel.org>
In-Reply-To: <fy5y73vfqfajxnm6hkzd5h4rw4xohz6tormbi6mgnnerptomlv@jwsxzuqdn7io>
References: <20250425214808.507732-1-saeed@kernel.org>
	<20250425214808.507732-3-saeed@kernel.org>
	<20250428161031.2e64b41f@kernel.org>
	<ospcqxhtsx62h4zktieruueip7uighwzaeagyohuhpd5m3s4gw@ec4oxjsu4isy>
	<fy5y73vfqfajxnm6hkzd5h4rw4xohz6tormbi6mgnnerptomlv@jwsxzuqdn7io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Apr 2025 13:49:16 +0200 Jiri Pirko wrote:
> >>Why do you keep the DEVLINK_PARAM_TYPE_* defines around?
> >>IMO it'd be fine to just use them directly instead of adding=20
> >>the new enum, fmsg notwithstanding. But failing that we can rename=20
> >>in the existing in-tree users to DEVLINK_VAR_ATTR_TYPE_* right?
> >>What does this translating back and forth buy us? =20
> >
> >Sure, I can do that in a separate patch. I think I will send these
> >patchset separatelly prior to Saeed's patchset. =20
>=20
> Hmm, on a second thought, we expose DEVLINK_PARAM_TYPE_* to drivers to
> specify type of driver-specific params:
> git grep DEVLINK_PARAM_TYPE_
> I would like to keep it as part of devlink param api. Looks nicer to me.
> Downside is this switch-case, but who really cares?

Who cares about pointless, duplicated code? I do =E2=9C=8B=EF=B8=8F

Why do you think it's "nicer" to have DEVLINK_PARAM_TYPE_ and
DEVLINK_VAR_ATTR_TYPE_ be separate things if they define=20
the same, exact, identical values?
If it's because DEVLINK_VAR_ATTR_TYPE_ has the word _ATTR in=20
it then I totally agree, lets call it DEVLINK_VAR_TYPE_ :)

