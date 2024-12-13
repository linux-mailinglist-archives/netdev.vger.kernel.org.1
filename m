Return-Path: <netdev+bounces-151625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1EF9F047A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 06:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD5D188A240
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F1189BAC;
	Fri, 13 Dec 2024 05:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A766F30F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734069547; cv=none; b=tZyQPTzOigazrBjgYop+4oAlp+2tBIMFQ9BiC90HPFUE6qqJ6MKxX0tLPPbzBwK5OOMWmeyi7wK/VfTO2YO00Z5A05fXaXnMXwOXlNO2JYSFCFh9pNHqJGPDXDb+FyiJYz19XzCg6Boz83X/vT9J6SW9UlilEPhLciqww+D0hO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734069547; c=relaxed/simple;
	bh=tpN3wXJhUfypCBPZodcpms4OFR8HaJwq48WrGxSfc9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y4QIQ2hm8RI/kdlFTCSUKK8mgrzAqnrLIxI8OY5PViaXjccKntdB+Ee0tMA6/kNZVNLaRGjfFYA9/I7XESqZWKN367bPLZhv7FU6CtnA+sk1EyNbwv0poYaSYXxMyC4xfzM+utocavOIGpqjkl4VkwJPPULsFu5e+3GvNMe1+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F2C38435CC;
	Fri, 13 Dec 2024 05:59:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id E060120028;
	Fri, 13 Dec 2024 05:58:48 +0000 (UTC)
Message-ID: <1ba4679ad8e0251b82512364149a94a83a358981.camel@perches.com>
Subject: Re: [PATCH net-next 1/7] checkpatch: don't complain on _Generic()
 use
From: Joe Perches <joe@perches.com>
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, Przemek Kitszel
	 <przemyslaw.kitszel@intel.com>, wojciech.drewek@intel.com, 
	mateusz.polchlopek@intel.com, horms@kernel.org, jiri@resnulli.us, 
	apw@canonical.com, lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
Date: Thu, 12 Dec 2024 21:58:58 -0800
In-Reply-To: <20241212190120.0b53569e@kernel.org>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
		<20241211223231.397203-2-anthony.l.nguyen@intel.com>
	 <20241212190120.0b53569e@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: E060120028
X-Stat-Signature: najeoxp6snrp55txcgu3rztj355gu769
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18bD7vzcmFbr6WZB481jatyG/zJ3nfE9xQ=
X-HE-Tag: 1734069528-897703
X-HE-Meta: U2FsdGVkX18MVNkbSsMD9wa2Mw8lk5Vh0WrriL2Da4UV0tuapacbRUmNVlp9q3FuzUnKFOS2W07naVPaD8pPGsvZIJ4L+/sMVHF/zH5jc9jR3iyk5FrXiVzn8k0dPm2rpNLr7ZkWwPDNFxPCxUDCAv/5+pmc/zq4B0/Hs0kHpv/6pq2wG8IHKvVYAtT5vMk2n97QxxpsG72wTsKwa8U/stptV4nRpSB0GbfF9W5bR3nGEM20IkUiST13hPS85Ni4DL7medZ/C7mzK4LCM+/X+L2PK4BGVnO4j1j80S3qmmThdicoCyRrP56M9CSrlNxt44MaXGtRWGkMvQwHGtj/t03nNriNyL8K

On Thu, 2024-12-12 at 19:01 -0800, Jakub Kicinski wrote:
> On Wed, 11 Dec 2024 14:32:09 -0800 Tony Nguyen wrote:
> > Improve CamelCase recognition logic to avoid reporting on
> >  _Generic() use.
> >=20
> > Other C keywords, such as _Bool, are intentionally omitted, as those
> > should be rather avoided in new source code.
>=20
> You're probably better off separating this out, we can't apply without
> Joe's Ack. I'm not sure what the latency for that will be.

It's fine to apply.  I believe I acked earlier versions.


