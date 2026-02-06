Return-Path: <netdev+bounces-257526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICArCJDIhWnAGAQAu9opvQ
	(envelope-from <netdev+bounces-257526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:55:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088DFCDD0
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF4A30547EE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558738F92B;
	Fri,  6 Feb 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NpQSTGU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B438F25E
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375148; cv=none; b=oCCXS7Sk6QtWb06Oamde/Q/jUamzOn/vsdYXdEURYZh3Ob+pFSfaxn75dPt2PLbqDBL0E/whhn/nd1cOG6/QV2c5LMWELeRqc5HRJRsUWkw7idUHS3whNzFQRgyLzZ+HgsUrRQK25WA6yaicnON+49MBzYNps/3zg3W5NtJR87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375148; c=relaxed/simple;
	bh=6o6KR7nghgzkDxl1nkVVieT0SH1rzwovWzzo4qPtUjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSfkkS/UaTyGfOxIOzm0EXwL7F77T2Qn2SeIA7gsMHkTPjsgDbsd479rfbf9Z6klT/qCLiaSYRxihCt2zLIbv8x31/vnS6hmGQVzNWDEPaVHC9cb4E7ZoJCOE+Hq8ztob+bWxeZ+opkQGddIQx/s3akaH5j+YgQYqL37kIUTQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NpQSTGU/; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4359249bbacso1881538f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770375145; x=1770979945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWdOoqfAHgDZZ2fSkAIYLWT6yGlK8Y5I4AE6a0ezGSY=;
        b=NpQSTGU/G3clR2EbpmRJmkTCCpS/1EhKXyVpKv7apmUyI7pZbkNSn/FLx4XhAy7ZqX
         16X8g94P7ER8FuvfRazlY7efGyO4+O4CI4b3UHbR47DLAUaxKcwtsRw6stF5jonpNNH8
         08QfgGyrIxTN722H7fPdljbtwkpTL5163eSwa2+gDjXr6630o1xvutBDkFmAICmjWMkd
         CnspGzLOzlF9Qn8txDr9rMiV/AoqXmq8k+xXsxHzC8PGpP7bo+vtNq1MEKNoG48b3rBL
         jazS8l9F7cGTzkPuSXmkec0mw6ULBOQd4UHMuQe5pIf+FG0PI7t6LUIGFXZ1Pmn8wuRF
         2mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770375145; x=1770979945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWdOoqfAHgDZZ2fSkAIYLWT6yGlK8Y5I4AE6a0ezGSY=;
        b=rddU6iSsnWqkTVFdQ1VmD/TzYyNjVn4gOMAR9m9W0Pvar8GY9OXzaA66lGsjdttGOo
         Yyept5nQJYjmHweE+AB3aXeSvcnvfIhAawAko1OyvSdJArEXcMRUNGLIAT02jUXGk/GB
         EsVc1yuBs5ITZmF7k/IzD71t4jfurQW5boykvBMqtfdbpCUI05NF92SRbNyoNzqovQo0
         EJba/uvDkDdWb7NsQEh0BJ6tGPZq6O+nGEvH89xvEiPHNyU7gs0H4R2V92SBwRzPv8Gc
         /VXXmKv/FMd8C4H7zYmwFGutEoCIdF/bPZFAReu49nqLzi2XW0Q2uLKpx6Z+p2xngbo4
         JnHg==
X-Forwarded-Encrypted: i=1; AJvYcCWBz4hfQOuKffKK+NZ/U9f0Crx7EeF1nbIedlzsrtIpdlJwvd8LnYDvEqjiBabRLteVqwigJM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFZ99uqv7qUMp6v+g48LfTupJDNmjyurXIjbaO7aVw1oy7yDZ
	3aNM+zqXqtAgNl2kNwoCJhD44W3OjV5mFLaCSqKIJ+zlpt6bz2JdbTtUlB6nFTOsROA=
X-Gm-Gg: AZuq6aLj9B0w71eg15o+QhZ3qNNc0G0n7YGNXwGXN2iieWr7Mu9m3IEWbQtOZhq8T0G
	suG9qQuFPYqAwJKU1xJdtYK5sdpsT173MAtLstTT4XakwZhQVpYWEsPBW9uy2pUcJEu5xR3fqcq
	TLwRJ5veUHXZe6DNtDATP/SuhYGoNdE9sVSK5xHI88MDeeqUd8zkNVADkqVy8ndmdQuQNOo5OO9
	uCotDKIcLAtwMhQeAf89yfdvy4/hctNuOm5fFwwa9uEuW/NNtcY5Z01/TL06R2P+fYriGqOgm/F
	RmxGoXl2AiPfH30ozpOyN5Do0p2RpdOdZQFLpMb9/t28ht/cclJHoCGnjQwuNKqom21jObTA7bb
	MCDi+YBi5V89rn24LpDNq32T6C6UIk7yZuk6GO7HRDtmF2cQ1fJMtXSJ6rmPgGBzIoR0O+CLmUx
	XPcvr+2hl/CzB7OaaQnQo=
X-Received: by 2002:a05:6000:18a4:b0:432:dcb1:68bc with SMTP id ffacd0b85a97d-436209c9896mr10061860f8f.23.1770375145422;
        Fri, 06 Feb 2026 02:52:25 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972faaasm4698415f8f.27.2026.02.06.02.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 02:52:24 -0800 (PST)
Date: Fri, 6 Feb 2026 11:52:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 01/14] documentation: networking: add shared
 devlink documentation
Message-ID: <khee3ri33uvtp4ssaqu7a6vy4mkbrp2zq6nghpbmyyc5pup6rq@hyryulfrhfl6>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
 <20260128112544.1661250-2-tariqt@nvidia.com>
 <20260202194023.412bb454@kernel.org>
 <u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
 <20260203190105.2cc28e71@kernel.org>
 <3edheaanzxgutuyryorfzlfjvizlorpj4y3ard5js7mp44hfii@4a36de6wazfd>
 <20260204180256.1476f537@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204180256.1476f537@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257526-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7088DFCDD0
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:02:56AM +0100, kuba@kernel.org wrote:
>On Wed, 4 Feb 2026 08:12:00 +0100 Jiri Pirko wrote:
>> Wed, Feb 04, 2026 at 04:01:05AM +0100, kuba@kernel.org wrote:
>> >On Tue, 3 Feb 2026 10:18:22 +0100 Jiri Pirko wrote:  
>> >> How exactly you can have a single devlink instance for multiple PFs of a
>> >> same device? I don't really understand how that could work, considering
>> >> dynamic binds/unbinds of the PFs within single host and/or multiple VMs
>> >> passing PFs to.  
>> >
>> >The same way you currently gather up the devlink instances to create
>> >the shared instance.  
>> 
>> What's the backing device / handle (busname/devname)? Best would be to
>> draw a picture, as always :)
>
>Either the bus/dev that shows up first or we go back to index.

That may be tricky in case you bind/unbind the PFs randomly. You may and
up with devlink handle of PF1 with only member PF2. Confusing at least.
You need to expose the members to the user anyway somehow. That is
exactly the list of nested instances these patchset is adding.


>(My main point being that the single instance is strictly better
>than shared, ie. no problem exists in single instance multi func
>which does not exist in multi instance + extra instance multi func.
>But some problems do exist in multi instance which do not in single
>like the locking)

I think that my shared and your shared are basically the same as far as
the nested PF instances are not really used for anything except the
modelling purposes. That should be up to the driver how he wants to play
it, shouldn't it?


>
>> >> Okay. I originally wanted to use an id, similar to what we have in
>> >> the dpll. However I was forced by community to tie the instance to
>> >> bus/device. It is how it is, any idea how to relax this bond?  
>> >
>> >Interesting! I was curious to research how we ended up here, found this:
>> >https://lore.kernel.org/netdev/20160225225803.GA2191@nanopsycho.orion/
>> >My reading is that Hannes was arguing against the _NAME attribute but
>> >both _NAME and _INDEX were deleted? I think there's nothing wrong with
>> >an index.  
>> 
>> He argues for "stable topology indentifiers", which randomly assigned
>> index is not.
>
>Agreed, I love me a stable identifier myself! :) That does not mean 
>we can't have ID _as well_ as the identifiers. Which lets us add
>more stable identifiers and/or making some optional.

Got it.

>
>I think I was trying to sell you on "more stable identifiers" 
>as a alternative to ALT_NAMEs for netdevs at some point ;)

I don't recall that. Anyway, everyone loves ALT_NAMEs at this point :)



>Maybe I'm projecting that conversation onto what Hannes said.
>
>> >FWIW using devlink day to day, the bus/device is not at all useful as
>> >an identifier. Most of code touching devlink at Meta either matches
>> >on devlink dev info or assumes there's one instance on the system.  
>> 
>> Okay, what's your suggestion going foreward then?
>
>Add the ID back, make bus/dev optional, forgo the faux dev?
>Would that work? Would exiting CLI become very unhappy? :S

Ha, that would break so many things, everything is based on
bus/dev on UAPI level :/

I was thinking about having some sort of *special-bus-name* for indexes,
like:

none/1
none/2
or
devlink_id/1
devlink_id/2
or something like that.

But it would be either that or original bus/dev, not both :/

Perhaps we can add ID attr as optional/alternative handle? Then legacy
userspace can use existing bus/dev handle and new can use the ID attr?
Then the example output would look something like:

$ devlink dev
pci/0000:08:00.0: id 1
  nested_devlink:
    auxiliary/mlx5_core.eth.0
devlink_id/2: id 2
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0: id 3
pci/0000:08:00.1: id 4
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1: id 5

Makes sense?

