Return-Path: <netdev+bounces-294680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91wfNp7iH2ourwAAu9opvQ
	(envelope-from <netdev+bounces-294680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:15:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C5635989
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZUviNPMI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294680-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5926D30B6CC7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A761409109;
	Wed,  3 Jun 2026 08:14:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF940B6FA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:13:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474441; cv=none; b=tOwK8wYGzF657/N1QywOxPJAOdznFB3K/R0c8NEoe5XlKb83F2yifi87D2iZpK15POiZAzE+3FNeTmFIu1uUeO4lVG/SRCwcw1vyuVWYH3BmXuoiuwbCr6YTM2G+7PI8VJeYPA+HEmC+pwfyKH44I4XynZPYyG/vFh5/4LCRF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474441; c=relaxed/simple;
	bh=CGhKMFuMoDwah+4sJpx4EA6RkW/ozoLUhZmN8Sda9Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js9rMnCYP3pFTqGpnx/uMnhNuQEMrUuVzWKSbs57q5cDYw1+B4tf32qc6FHLwL+k7m6laqsYIb/5+1qbIH2LTEA7pJTgbr7vg9YlgdN+UGExuZxFQhNqZknVt+Btdb2WTCzjXKvNfLVonz1KElX5dboARDXlk8dHbytDZmrR8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUviNPMI; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so124903695e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780474436; x=1781079236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIZTdhmXRFcog4PaDUh+gp1Y3zEgNYGm6Wt55FZv7VA=;
        b=ZUviNPMI3XO4Honqxj6hjd6E8qSS+iYSmISSna2LAfcwsQ5EcuLd400mijRCRuenJb
         RHLxqIqeO5ESD9B0/SyB9xbokKj1LAakGhjmRsILxFGUrwtfT1MBmvK+NE64iWPu/4Wl
         Du3PnPnDdJuuaP0u925BVI72NHGd4JVxs76imNoaofK6aFSUfm/UWq02JgR4KgCcP1B+
         0YY3gn2b/roNn+/DRu8X7Y0Tvsm5GLn1iRoleavYfohCW3X3zS+S+OPqrNY7VJ7QGy1h
         xh2rS176jIF5LrZmreYzxYwliGl8fZE7f/RTvwlZDvgyNsZIbznA3ycGL7o43t9VYKw+
         OTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474436; x=1781079236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kIZTdhmXRFcog4PaDUh+gp1Y3zEgNYGm6Wt55FZv7VA=;
        b=DV+R6Rf8DUzFKi90TdLDN8zF3Mbm2m0vusFMGPwHgbIBVRXKEtFsdG1FTQ98KykV/8
         qceqe+6BhzZKacbmDkFdzVqMulaMZ1WE1nJud6uvPU8w8LNcqDUMTLNPOk3WspUBPv8p
         VRwBS79Md2cgM9GMSbIqX8KWMSE/q/+YtGYMAgbCn7mgilWP7EmJzvNznmluQVk4MYmK
         +yOxbLvnhJIAu/QbWqezjlyn03bgOAZoOm7t8W9crUNiurWBAXR380pqBxqyB7HPI0hB
         PsUXhw30VSNAINvPavekC5isj1GmG07syIkQlpMj7IkyNWUAZbq7vwts7KXB40lMN7B4
         nr/g==
X-Forwarded-Encrypted: i=1; AFNElJ//IjjCu9Yg68H5AVA+7IGiYBaIuxynbv9/6jOxX4srbJbrw1iI3uaLjO7pCHlFwhdWCZ/5wrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlwpxFd9QDN0Gbtp7UHscCSTddcOqf6NxSdpJ5OEd1qJ3u9K6
	iUWcVZD/+OZOYUauDq+ThB2Mphtgr37JPekYRcnREx0oWoWNzWWyhdJP
X-Gm-Gg: Acq92OFp8Xdx/33Pca9qi6rJFB8tje8w0mcMLfiHVKqL8GBUa/KcMB9nhhbkT+IUjmm
	jUrK1w528q5etyGhdb1HeW3wU/4jemwIuneMTdWeZOupCw73OnQmjtPYXi8TQ+FTFoe8xwCepI2
	bmVweTYtvu9UDeVaWpQ4d5M3OTaqPBUtRSARGusav+Knd1+Pg58Um0rNDhO+zHjh3H8s8MTFC+K
	Yzez1RgbxTiZRqiycpAoaqKcnyifyKB3t+29mXzTkMfy+6+3dABqv2ujTUwnYH9iIBbQLEj9M4f
	eCA2eWxnOXOlhe0JQadDeBEQ/hyb/+skNGNIPAKXf3tOLmzBwMZUB86gEPLzWRTztHvL0N+iTuv
	NL0wYt0txu/YBAYCFr911x6VMxbTRJEtbSnk/JQCy1fJKPnKxsq5dnUuGuw4jQqtEPf+GjlsYiw
	sn8x8IVczy7HzW475FNTX7l1iBHRN3YgjmbLKOwf51hP2Rwg+5z2rNgDzvuypEmVXPatugZ6U=
X-Received: by 2002:a05:600c:1d09:b0:490:3f7a:108b with SMTP id 5b1f17b1804b1-490b5e51a49mr37669295e9.16.1780474435776;
        Wed, 03 Jun 2026 01:13:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20a24sm122157465e9.5.2026.06.03.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:13:55 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:13:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Piergiorgio Beruto
 <Pier.Beruto@onsemi.com>, "parthiban.veerasooran@microchip.com"
 <parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS
 size in RX frame
Message-ID: <20260603091354.62b65ec3@pumpkin>
In-Reply-To: <f295db46-3d10-47e9-bc22-582fe3fe7851@lunn.ch>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
	<cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
	<20260602150712.5b28d58b@pumpkin>
	<CY8PR02MB9249B26D4B4344064A582A3C83122@CY8PR02MB9249.namprd02.prod.outlook.com>
	<20260602223807.1ac76456@pumpkin>
	<f295db46-3d10-47e9-bc22-582fe3fe7851@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:Selvamani.Rajagopal@onsemi.com,m:Pier.Beruto@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 481C5635989

On Tue, 2 Jun 2026 23:47:23 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > The frames are padded to a minimum size so that collision detect works
> > on maximal length 10M coax segments.
> > (Or rather coax+link+coax+link+coax acting as a single collision domain.)
> > The same minimum frame length is used on modern networks which are all
> > physically point-to-point and all 'hubs' are store+forward where a minimum
> > packet length isn't strictly needed.  
> 
> You need to be careful here. This is automotive T1 system. They do
> actually have old school CSMA/CD. Did i remember the acronym correct,
> Carrier Sensing, Multiple Access, Collision Detection?

That's what I'm remembering it being.
Somewhere I lost (or failed to steal) the hardback (IIRC) 8802.11 book
that explained it all (I doubt it was even 100 pages).

The max length collision domain is a 1.5km coax segment linked by a 1.5km
bridge to a second coax segment and then onto a third coax one.
The minimum packet length has to be greater than the round trip time
from one end to the other.
I doubt a car has that much cable in it.
It might have a 10/100m HDX TP hub that creates a collision domain.
Under load it should retransmit rather than discard.

-- David

> 
> 	Andrew


