Return-Path: <netdev+bounces-166435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535CAA35FE6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E77016C40C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E7264A82;
	Fri, 14 Feb 2025 14:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E33261376
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542184; cv=none; b=o4FaVQW/2kMXToARvitiwpgNDhAjDUTOFLzBLSBZDcBQtQx/EbxpJS9n8ggE6CdxxWjpxzevq+Kgbp9M/4bOoTKZiBsn2mB0tefYVQUrruc74xWXLiItAz+1WMTILQCe4kTLH9OGXRK/dyeT08ZDwokhh6uJln6TtvRB5G16ekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542184; c=relaxed/simple;
	bh=c8aTG/Ae42z7StuITPOfTKTRfJ7z/SJOWehc1SBqnag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9yUpYcv+eecpDhvgouB9yRynCO4SqIdkMmDt6Qn1sJFB0IY/7lc1/NhJFrQrWhTOxA5bYMfCP5hbh85Xnug7RycyfSsqbb9bi6ZDIATiicg5A0BlqdaX5tbF0Wk04hGzlWbw7M/KehrX6ad4G63i5pmHfZVLaHAu50M+NNvzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8CB6EB033C;
	Fri, 14 Feb 2025 14:00:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 6C72F2002E;
	Fri, 14 Feb 2025 14:00:18 +0000 (UTC)
Message-ID: <06ba971191eeb80cea711653b737b16221899cf9.camel@perches.com>
Subject: Re: [PATCH v2 net-next] checkpatch: Discourage a new use of
 rtnl_lock() variants.
From: Joe Perches <joe@perches.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, Kuniyuki Iwashima
	 <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Fri, 14 Feb 2025 06:00:17 -0800
In-Reply-To: <c25c5efe-6835-44fb-9937-87bf25368a97@intel.com>
References: <20250214045414.56291-1-kuniyu@amazon.com>
	 <c25c5efe-6835-44fb-9937-87bf25368a97@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6C72F2002E
X-Rspamd-Server: rspamout04
X-Stat-Signature: a9z6mkdskhga6kxp1objeaik63w6rq81
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JOd/SfB9yPb5AiLmlIXaTGe4d9bd0GSs=
X-HE-Tag: 1739541618-817973
X-HE-Meta: U2FsdGVkX1/Im1Tt+AxiLjpqgOL3UcQ2w6LBwe1wmD2d/e8IuZiZK9m83shiC6nm02+7PlevFhs+8RyHC2jah87FOTqnXT2LbKkX+QQcVoU3CNW5I09eOQGbcItzbcEFZj5pZbEoO0C5N7eim5f5nwPbWvUnXgbTkhZ5NYxCCkKGzMKmSEORFwpAbmWfCPgEmKuDAGUDOZ0UP3qcAXdNvNhK1IL5GE633mDg/kjYSeK71ilBcORZyTDRU9ngTjNe31/5QUBhjHT8pRNy05NmyHjV/a1kqBC+plP0VI/O4XSSIe2R0CfH7llm2LNQEnaQFtODHF47PQTgIAVIlm3isQ/9l+iBMrgl9zgVSTXD7c1pfFK7XUW2XA==

On Fri, 2025-02-14 at 10:24 +0100, Mateusz Polchlopek wrote:
>=20
> On 2/14/2025 5:54 AM, Kuniyuki Iwashima wrote:
> > rtnl_lock() is a "Big Kernel Lock" in the networking slow path
> > and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.
> >=20
> > Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
> > very large, in-progress, effort to make the RTNL lock scope per
> > network namespace.
> >=20
> > However, there are still some patches that newly use rtnl_lock(),
> > which is now discouraged, and we need to revisit it later.
> >=20
> > Let's warn about the case by checkpatch.
> >=20
> > The target functions are as follows:
> >=20
> >    * rtnl_lock()
> >    * rtnl_trylock()
> >    * rtnl_lock_interruptible()
> >    * rtnl_lock_killable()
> >=20
> > and the warning will be like:
> >=20
> >    WARNING: A new use of rtnl_lock() variants is discouraged, try to us=
e rtnl_net_lock(net) variants
> >    #18: FILE: net/core/rtnetlink.c:79:
> >    +	rtnl_lock();
> >=20
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > ---
> > v2:
> >    * Remove unnecessary "^\+.*"
> >    * Match "rtnl_lock	 ()"
> >=20
> > v1: https://lore.kernel.org/netdev/20250211070447.25001-1-kuniyu@amazon=
.com/
> > ---
> >   scripts/checkpatch.pl | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -6995,6 +6995,12 @@ sub process {
> >   #			}
> >   #		}
> >  =20
> > +# A new use of rtnl_lock() is discouraged as it's being converted to r=
tnl_net_lock(net).
> > +		if ($line =3D~ /\brtnl_(try)?lock(_interruptible|_killable)?\s*\(\)/=
) {
> > +			WARN("rtnl_lock()",
> > +			     "A new use of rtnl_lock() variants is discouraged, try to use =
rtnl_net_lock(net) variants\n" . $herecurr);

UPPER_CASE ALPHANUMERIC only for the key value please
and there could be whitespace between the parentheses

Perhaps:
		if ($line =3D~ /\brtnl_((?:try)?lock(?:_interruptible|_killable)?)\s*\(\s=
*\)/) {
			WARN("RTNL_LOCK",
			     "New use of rtnl_$1, prefer rtnl_net_$1(net)\n" . $herecurr);
		}

though there doesn't seem to be any uses of interruptible variants
in the tree I looked at.


