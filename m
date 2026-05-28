Return-Path: <netdev+bounces-292579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGVdNBP1F2rNXQgAu9opvQ
	(envelope-from <netdev+bounces-292579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF45EE169
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D76BE3005D2E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7D350A10;
	Thu, 28 May 2026 07:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132E33D4FB;
	Thu, 28 May 2026 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954624; cv=none; b=pbu3VeCIL21hvqaTFugt6oimAxTDnBvEac6EisN3fVTvfnomrpXtF6P8kTgFEgfdzuUKphx0H3lkS9MjpxW8smY93Z6fc0tDdQ67z4CU/YPkv3f4ViPA6jvzpcIdNJAQ26ZnJdtc20hLoWBbQhIzQc/1E5NtxppqH/yfoDfTXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954624; c=relaxed/simple;
	bh=emc4zUX6NmJU4RwB16CYry5ahUhaV/+whFqF1fX3UvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmxZlhx9FZ8fRAKPDcFgpft8TV+OSWTgcREohsD8GBQSpdc+sQxef4VEMKu0A/sFVfKqDoeZFZA6tJMh6idc3ZEFMJDzVtAv0uoH+NQB450hxjtUaohnbQ24meF4khqlvbaMIY3kq7ABNTwgrEDWoJ+JyZCRcwYJmudlYnZfbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id DB0D71035A4;
	Thu, 28 May 2026 07:50:13 +0000 (UTC)
Message-ID: <0efedf54-9afb-483e-b830-4f69a3220108@enpas.org>
Date: Thu, 28 May 2026 16:50:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] zorro: Simplify storing pointers in device id
 struct
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Max Staudt <max@enpas.org>
In-Reply-To: <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[baylibre.com,linux-m68k.org,kernel.org,HansenPartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,gmx.de];
	TAGGED_FROM(0.00)[bounces-292579-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	DMARC_NA(0.00)[enpas.org: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max@enpas.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,enpas.org:mid,enpas.org:email]
X-Rspamd-Queue-Id: 35BF45EE169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:17 PM, Uwe Kleine-König (The Capable Hub) wrote:
> Technically it is fine (on all current Linux architectures) to store a
> pointer in an unsigned long variable. However this needs explicit
> casting which is an easy source for type mismatches.
> 
> By replacing the plain unsigned long .driver_data in struct
> zorro_device_id by an anonymous union, most of the casting can be
> dropped. There is still some implicit casting involved (between a void *
> and a driver specific pointer type), but that's better than the approach
> to store a pointer in an unsigned long variable as this doesn't lose the
> information that the data being pointed to is const.
> 
> All users of struct zorro_device_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>


Thanks Uwe!

Reviewed-by: Max Staudt <max@enpas.org>


