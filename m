Return-Path: <netdev+bounces-168826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37040A40F48
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827FB18857FF
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030D1FFC53;
	Sun, 23 Feb 2025 14:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5931FCCE8
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740321239; cv=none; b=FvzQqX2rCrkNwvHEpdclRV45pVItnLsth2dZLITHEn3hKOgy767DVMosZ7tS9c83axURwtuYATkzpU1X6Ppj4sDk/8oI2e9+iSviUuDZeGeyKl6dzfdtuJSm2CVSIENEfHXcrCQue/Ci6q3unegnBkkqRk8ymgJfvjWf5IId0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740321239; c=relaxed/simple;
	bh=7lIUhvjDQXmA8N0+09UM/IwuxvLo1nT1l7VBOZy79DE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=puomI26t4I7dYWOczSzezSoj6ARy0kwc738nbMF6AZ/ZPYmqDhG/7xINdlQDdaVJYyjcAizbJkzGcqhY6Gi0bo0RjaG3Zxnex75bv0ZgyAXy8ffvYYt8olR/3IS3bR1ncewAjiV3Vg+DN5wBMrplg23Hti2/LVEfJIjz5RUTbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3AEDFC2A6D;
	Sun, 23 Feb 2025 14:33:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 9D56620027;
	Sun, 23 Feb 2025 14:33:45 +0000 (UTC)
Message-ID: <7bf9577f4b6dcb818785be73c175bcd19b3b4f0c.camel@perches.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: thead: clean up clock rate
 setting
From: Joe Perches <joe@perches.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
	 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Drew
 Fustini	 <drew@pdp7.com>, Eric Dumazet <edumazet@google.com>, Fu Wei
 <wefu@redhat.com>,  Guo Ren <guoren@kernel.org>,
 linux-arm-kernel@lists.infradead.org, 	linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Date: Sun, 23 Feb 2025 06:33:44 -0800
In-Reply-To: <Z7sJHuiqbr4GU05c@shell.armlinux.org.uk>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
	 <Z7sJHuiqbr4GU05c@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: esw3dr8mhka38dy95jmw4hywg8muj68u
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9D56620027
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wRTpTpK3yZctHayRKM8k2m6yVovYm8rE=
X-HE-Tag: 1740321225-99173
X-HE-Meta: U2FsdGVkX18tLefx9AGTjZ0jhquEbj97fUAGJuLtZQssX3hWFu5sggBKHI4DwjWn8Zwn0QpW3Qr0HmBXP3ocR/MHKikZ9oAZK2xrnR9ATgzsWS1svxwvKnlT9OoQm5zxwAd/ZvqtW0AzDPqtc7FJP8cp33TVipXmpgupjKGtdNm8SwEeZaEALT3gFjUOydgga8gwmPF+qQG/2CHmqq4HGIIp4ZOJJjRR2ZedoQ80uSlycAsw472d4W8xMshd4NzXp6DYOxPADh0pAXMVHh37IPsPhCUT8YcB6bGYItqwGeOZ3/iGOfn9LRbizQIKBTGHXFkaAqVaWP8zsH3fGG8hmSj4Hv7mOeLeo/OdWEF/C68muP3EJXVkcAgoX9U7poXD

On Sun, 2025-02-23 at 11:40 +0000, Russell King (Oracle) wrote:
> Adding Joe Perches.
>=20
> On Fri, Feb 21, 2025 at 02:15:17PM +0000, Russell King (Oracle) wrote:
[]
> I've been investigating why the NIPA bot complains about maintainers
> not being Cc'd, such as for patch 1 of this series:
>=20
> https://netdev.bots.linux.dev/static/nipa/936447/13985595/cc_maintainers/=
stdout

Additional maintainers added or missing?

> So, it seems running get_maintainer.pl on an email received from
> mailing lists without first stripping many of the email headers can
> lead to false K: matches.

My guess is the nipa bot should exec get_maintainer.pl with the
--nokeywords option on some pass it uses after cc's are added.

Or are you suggesting that lines that start with "to:" or "cc:"
should be ignored by the get_maintainer keyword test?


