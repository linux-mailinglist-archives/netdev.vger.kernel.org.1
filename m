Return-Path: <netdev+bounces-272932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K8HkAiBNyWmGxQUAu9opvQ
	(envelope-from <netdev+bounces-272932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:02:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92A352BD5
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC78300A775
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A723EAB8;
	Sun, 29 Mar 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="XMTrtt7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D128F5;
	Sun, 29 Mar 2026 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800157; cv=none; b=MRlQWoXQeIm1OJtaq4GamlJ+oWH0dR/1RelQ00ANl0w/RVZyI0lBZKXyFb1MfuEcpdtA0duOzU6akf15Z1Fin6mjuIvWF3Vvndf04iZbkQCm8tFSNl2xT93ecU2Y1OGR6iovEi3ypT5EnoWoZo1T0ftZCkA5x3f2fImBEBoZVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800157; c=relaxed/simple;
	bh=9rH5GAq4AqXtdoG0CE1gaMfZpzllUXPTe55W8AddnOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MonfRoKEnzZHudYteHHJQCK4T4gq1xls3W4qgZse8f5y0gskk7zO1jmGEVlWebDhfAUQF7wTHleAHrgfHX5UObwOD32M9Bx0wFcquC8WfuRFC7nRUS+X6l4q33DK1Nb4pjPtBIrZ4DgVr2SBxIoJ3fslE9wHgrT6rJ5fKbNKvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=XMTrtt7h; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [79.139.247.223])
	by mail.ispras.ru (Postfix) with ESMTPSA id 25EE6406C750;
	Sun, 29 Mar 2026 16:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 25EE6406C750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1774800151;
	bh=wsYFc3Tx9EISvC1vyUkGB5FPr7lo2/T7m98WS8sicfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMTrtt7hMEZ8CzZI90QoUDs3OLWEoOmS6/3M6V6qtyg+rEx8B6Kp/tTa4X4VVdJJc
	 sqbovAZxM8nFZuihgPu41DKntdu4zJv81wz/cTuk7Kc7I9th7kje1oZAT7ypCbmQqz
	 Im/2VlOgs69XGfX8y9obf6+6O7vLibYppE45UOW4=
Date: Sun, 29 Mar 2026 19:02:31 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Agalakov Daniil <ade@amicon.ru>, lvc-project@linuxtesting.org, Roman Razov <rrv@amicon.ru>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniil Iskhakov <dish@amicon.ru>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 2/3] e1000: fix endianness conversion of
 uninitialized words
Message-ID: <20260329181905-cf917b74fe3e24dd60228601-pchelkin@ispras>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-3-ade@amicon.ru>
 <5128e54e-4164-4cb1-8ae1-e58d6a40c005@intel.com>
 <20260325180127-711d8e8fbff840853081f11e-pchelkin@ispras>
 <3a0f74f0-7031-43e3-8268-473badd9f1fe@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a0f74f0-7031-43e3-8268-473badd9f1fe@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272932-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B92A352BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25. Mar 16:01, Jacob Keller wrote:
> On 3/25/2026 8:19 AM, Fedor Pchelkin wrote:
> > Hi,
> > 
> > On Tue, 24. Mar 16:26, Tony Nguyen wrote:
> >> On 3/18/2026 5:05 AM, Agalakov Daniil wrote:
> >>> [Why]
> >>> In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> >>> words. However, only the boundary words (the first and the last) are
> >>> populated from the EEPROM if the write request is not word-aligned.
> >>> The words in the middle of the buffer remain uninitialized because they
> >>> are intended to be completely overwritten by the new data via memcpy().
> >>>
> >>> The previous implementation had a loop that performed le16_to_cpus()
> >>> on the entire buffer. This resulted in endianness conversion being
> >>> performed on uninitialized memory for all interior words.
> >>>
> >>> Fix this by converting the endianness only for the boundary words
> >>> immediately after they are successfully read from the EEPROM.
> >>>
> >>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>
> >> While this is definitely better, I'm not sure there's a bug here since it's
> >> being immediately overwritten. Seems like this patch would be better going
> >> to *-next as an improvement.
> > 
> > It's worth stating in the commit message that the uninitialized memory is
> > touched with le16_to_cpus() in the loop only on BE systems.  Little-endian
> > ones are not affected - le16_to_cpus() is a no-op there.
> > 
> > Anyway, for the BE case, touching and manipulating uninit memory bytes is
> > still in general considered a bug, even if this memory is overwritten a
> > few lines after that.  I guess if KMSAN supported big-endian architectures,
> > it would hit this, and that wouldn't be a false-positive.
> > 
> > I'm not aware of the details on how you treat the bugs in these drivers
> > for BE-systems: maybe they aren't prioritized and then would occasionnaly
> > go as -next material.  But, again, this situation looks like a real bug
> > worth fixing on BE-systems.
> > 
> 
> Typically the bar for a fixes and a net change is that it requires some
> user visible behavioral impact. That's where the hesitance on our end
> comes from: how does this cause a user-visible bug?
> 
> If there are truly user-visible impact on BE system for touching and
> manipulating the uninitialized memory, then it makes sense to go to net
> for me. I guess "KASAN/UBSAN complains you touched uninitialized memory"
> would be such a bug.

My first thought was that reading and writing uninitialized memory is just
undefined behavior in C.  It's hard to say what some compiler might invent
here.

The current situation is not trivial though because there is a chunk of
uninit memory allocated with kmalloc() to which we have a valid pointer,
and we are swapping the order of uninitialized bytes inside this chunk,
i.e. reading/writing uninitialized memory.  Basically it should just go
down to swapping garbage values without any suspicious compiler
optimizations - I don't think the compiler is aware that kmalloc() returns
uninit memory.


KMSAN actually supports one big-endian arch - that's s390 (the only arch
except x86 that KMSAN supports).  I've tried quickly to trigger the splat
out of curiosity, but booting the KMSAN-enabled kernel with s390 QEMU TCG
looks like taking forever so unfortunately no specific results here.

KASAN/UBSAN don't catch error patterns of this type.

> 
> Alternatively: is there a risk of some side channel method to capture
> that uninitialized data and leak kernel memory? I don't recall enough to
> know whether that would be an issue here...
> 
> I don't personally have an objection to going through net (besides
> fixing the commit hash for the Fixes: tag on the patch that was wrong)
> since its an obvious fix.

Thanks for the feedback.  I see Daniil has already sent some newer
versions targeting -next.  The problem in question is rather obscure about
severity of its consequences but spending some time on investigating this
now I'm more inclined to think there should be no opportunity for UB here
and it's okay to process the patch like Tony suggested..

