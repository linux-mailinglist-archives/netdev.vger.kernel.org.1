Return-Path: <netdev+bounces-52110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1EF7FD548
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3542826F2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AE1C290;
	Wed, 29 Nov 2023 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahoKKx1D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3RVPLeK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C131FDC
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 03:15:51 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701256550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojjqn6RAZ7dRmbhoMLtsEoETVpSbscfP7NVTUIt6ulI=;
	b=ahoKKx1DqT1QhEA5R3lCjFX38Wdn0ZEENUvdMdpGsqVwb7c+HArWuoSVzrmz6dEH0ZpiEj
	2/TwjG4Y2z81vv9FaSIa3qNgoLEAGcDqLnZA245E8KcR6/bUEIJ5yvWISxh/NK8Lef2VaO
	XWQg/3vmbR9co6nwWjnS8QUaAVW7jWq+JKY3sj2yuXQQt+1cM3dX86cEoqDwj7oBPnYwgB
	NL8Blu64b4hOBjDK3ZDceBKd1Ul9+2d81XghyS7fb5KY0kJngbIv2h/1DikVBvI1105Ep5
	/kvJxmVyoP97l0vXBDHHQNtwpY6AQpEdWcvb8mkM+v1tTdPFPI8k0sIBiyafhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701256550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojjqn6RAZ7dRmbhoMLtsEoETVpSbscfP7NVTUIt6ulI=;
	b=q3RVPLeKPyDyIvMyMW+C3YL4d1utIhR2gP28DadJEIrBWZmq9FuPkjn1+7p3CWQBx3ZkAq
	pA23Xn2t70NWf5Bw==
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] igc: ethtool: Check VLAN TCI mask
In-Reply-To: <87bkbdsb4b.fsf@intel.com>
References: <20231128074849.16863-1-kurt@linutronix.de>
 <87bkbdsb4b.fsf@intel.com>
Date: Wed, 29 Nov 2023 12:15:47 +0100
Message-ID: <87leagstcs.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Tue Nov 28 2023, Vinicius Costa Gomes wrote:
> Kurt Kanzenbach <kurt@linutronix.de> writes:
>
>> Hi,
>>
>> currently it is possible to configure receive queue assignment using the VLAN
>> TCI field with arbitrary masks. However, the hardware only supports steering
>> either by full TCI or the priority (PCP) field. In case a wrong mask is given by
>> the user the driver will silently convert it into a PCP filter which is not
>> desired. Therefore, add a check for it.
>>
>> Patches #1 to #4 are minor things found along the way.
>>
>
> Some very minor things: patches 2,3 and 4 have extra long lines in their
> commit messages that checkpatch.pl doesn't seem to like.

OK. checkpatch wants 75 chars per line. These patches have 80 set. I'll
adjust it.

>
> Patches 4 and 5 read more like fixes to me. I think they could be
> proposed to -net, as they contain fixes to user visible issues. Do you
> think that makes sense?

Probably yes. I'll sent them to -net instead. Fixes tags would be:

 - Patch 4: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
 - Patch 5: 7991487ecb2d ("igc: Allow for Flex Filters to be installed")

>
> As for the code, feel free to add my Ack to the series:
>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmVnHWMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguX7D/9QOX6/YZWQUibiAo/cINtmbD3KxNNW
IX0gBMf+y3vcEhM0tUI0BQqraMaxuPYZpYZqyTch+Tew2NzPcSazAx5/Ijvzve53
WI+U2DqRlo0ow3KY/shXX0pTR8sCvqPRGzZ1hqPR2vbnqai87TBSz4rD/jcGob+9
7sND2eYDy50zt25St9kPqCj23UEE6G6b/uH0Pqm0zNeCaX+Z4tV4fZJ+MHgnjweF
xa9QOSLxfgBACEZO6XtKbFYOX8CdVLN/dDD48dQZYzXxmFlH6qKgIXNbXLTLtaMb
exC5Au75iZJT78UiFS6bIBtfke4yMDvpf0e6DRStfYdBjJ71QVuMpXe5Kc4cSagH
FvZcll0OBreKWRCPA9K797m5KZoi7Mky8CBdRMXPMoZ2D0X+zJ1tu91tGHCh9Vnb
10gsM1zl4uTB421dpSDqBI2LtbkGhIpH/id5JaaluI7yv4QP4w2ksA++39rZ1fMy
ax+TM64bFx7VoCtupb/WRBXwjgk25eressB83mb45k3ZHxPa27aZcKcthNNjySwh
mQ0OCcVzKi0/M81rKzXJ6O/I9iLATh+Eb10nzwlbrR4IfnwPa7yhePdzGtbZKpH2
fqFl/1LyA4K+GHEMmsessAVSxu1pmZ2ixW7gOgkSyieHXNbp3ZftHwZW65WRPksp
BHv9pHHT6jsX0Q==
=M4Tk
-----END PGP SIGNATURE-----
--=-=-=--

