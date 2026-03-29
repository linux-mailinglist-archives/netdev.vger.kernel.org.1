Return-Path: <netdev+bounces-272875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICN1Bk4KyWm5tgUAu9opvQ
	(envelope-from <netdev+bounces-272875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:17:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68294351C44
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35D5A300D708
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9573F35AC3E;
	Sun, 29 Mar 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="v7z0bpqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7435AC0D
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783051; cv=none; b=utrbu6wHYDddrItqRBUaVdNJKP9D49SjsS2FPcqASbe+9p87hj9pzUB1xoG+UeNW5eEvYdaVIg6M6AXosLZYWFYnfAHB/15u87R9P2I58WyoegfsTQuYDNyddYTPwC0NVUHJpnyMTCZXcBA+v1RuXgSfMlhTCVSZLvFqdyDMDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783051; c=relaxed/simple;
	bh=QHOIkggUiANlpWTfqj7rQD3MmCJYFw+IMyrljO9+Gnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mhrye5Z5MUU7f39RMO0OAGuW/Ku72XH1tlceTpjkmM+f+ARh6TjrANFm/ClNDrBU9WUQVk5TsS7WWDFLiFgWWqKayYAyq2heypCRn314fFQCmnbFiFp+XltySEa4SOu17HWah3E5CVOw1a9dTiA8DMW3zASF1qDKuC5cOqMK0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=v7z0bpqL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso29831555e9.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774783045; x=1775387845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZZEbvtH/bKZ6jbXxyKNF2VJCYpTcm4/gV6VLpLYICA=;
        b=v7z0bpqLGgrvndYwhfu1T68MJN1fZh2h1mDA2x5WJDpHLwlEOSgp+crxvT0s8MLPdr
         RWHhy0MiTskG71QWA4Kgda+dal/IEmUl8IeRtdSuBiGys/t7qzvjy3SzaLj14/IU8a3u
         8kwSIYt9u2htte7ct8CuYpuvp1nx2nxj0R88s2kqvpWh+kVT3G/EUsokseVAOeFWE+1D
         wzAHvcv1Bt4fAObCpR1B0tZNJvPtoqQdVqrNs8yV9l0nHl27bJjaRgSkmKfdApWhj+3n
         Monrq/cyVpPbfeuC4BdIcwwGXs9T70v3zv/WnNRmDWM/s4izZcT9WjhXJd3VTEeQpM5a
         UIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774783045; x=1775387845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZZEbvtH/bKZ6jbXxyKNF2VJCYpTcm4/gV6VLpLYICA=;
        b=nOdYWBVkXgleHR9552z3mHb2gipgZmnJsDyZ3C799ynQJ+LIgJTSAOcIYNNcsfJSyV
         43xJ8/oaStwBLqaKxEW9o2Npgduy417VuFc2ztB7dKyt6LmcoKXArJ23BEx1oNqn5A4k
         l+26J2iDPPBwS556MW6sMxWCXOiA7+mrUWjEr3jFLPvMjhzTCWgiChrdAXHVfdKasm+k
         IGk05G2iG65IQZedJ37YV5pBt2h83OsZF9/BbaSyeMrHo0wDpTQkvNeEFgf9s/azqZUI
         fQTt8I7UvEV76MeGdKlQAqDA0dXPCVBxYV/p9fyOX29mlmso6qgd1TH1IWElNxV8Q/Yv
         EGWw==
X-Gm-Message-State: AOJu0YyiqDdB16BK8MxqsmzsjNqC3kq/B96Ld4rn1gm4Rt8KDspK06Py
	exZlz6DYamisazZQ2vvhnzDCfYzxeXrPYyq2Q5O3ogLgc8uSJcjVXcQ6lehtmJRyOn/7U2WQDB8
	G+yb39cM=
X-Gm-Gg: ATEYQzyy7d+uOdFmwa6B7B5nSH4+2nDQJx/ZoeRabVgLgc83DmZHZ6sSgNc4CkqH0WH
	ZyN7AYXqJA+YdVNSlBD81lx8Et0yW2d65NPqe/2rck040ImiE+gFvD4/nQTqsoz726ObnQL98Dy
	brmhfnPAHcw4LR98wWYfvmXNHeCFvjriJI4ypPTrRKTzSlXxjnawW2ndp70rP3edkY1wmlxHEmh
	Pl6DvUoqBzUv9Xs5xo37R5Am7mzy1mfJM6yYAFC1crZyvvjrb3Lj/n3eKM6mkidO7D0Z4VvpO4O
	VeK1lrvddl7ptW+33Wkbf+lkbPDey6k5I3L+DjhtsbsNJB0zpnWSN38s4/d6i7yfV+BOk/D7Ivb
	HCsh6zBfpPezj0qJTDRXVWc/4eRwmVAvFGUo1QM6msRNE3lb6LG1lcuZeEg32RXh9zvyqWZ0AMC
	ZlTH1/JshE+hY2OxEIPrfS+TRY5GN3K5qABvMR5mmjz+I=
X-Received: by 2002:a05:600c:41d1:b0:485:364e:934e with SMTP id 5b1f17b1804b1-48727eda4a4mr87253735e9.21.1774783044663;
        Sun, 29 Mar 2026 04:17:24 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4c27:3a72:8516:e661])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm11810601f8f.11.2026.03.29.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 04:17:24 -0700 (PDT)
Date: Sun, 29 Mar 2026 13:17:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com, horms@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net-next 2/2] devlink: unregister shared devlink
 resources on destroy
Message-ID: <wpjltue5gnv4e42a7cpewbgqeza7sl226qbgbbqjl7b2cjgtfc@kjqjqluv3vcb>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-3-przemyslaw.kitszel@intel.com>
 <aa7hsleso6z6zaubb6phx4lexqnthgdvkns5cpg75gk6w3pi3o@7skrmgryitsj>
 <b78d4c11-e20b-4a84-b8da-2638df46c46c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78d4c11-e20b-4a84-b8da-2638df46c46c@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-272875-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 68294351C44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Mar 26, 2026 at 06:44:49AM +0100, przemyslaw.kitszel@intel.com wrote:
>On 3/26/26 06:20, Jiri Pirko wrote:
>> Wed, Mar 25, 2026 at 07:26:53AM +0100, przemyslaw.kitszel@intel.com wrote:
>> > Since shared devlink acts as a normal devlink instance, capable of all
>> > usual devlink operations, it must unregister its resources.
>> > 
>> > I plan to make use of devlink resources on a shared instance for ice
>> > driver by separate series, coming soon.
>> > 
>> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> > ---
>> > net/devlink/sh_dev.c | 1 +
>> > 1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
>> > index b85e5cb1edbe..5de138bf3630 100644
>> > --- a/net/devlink/sh_dev.c
>> > +++ b/net/devlink/sh_dev.c
>> > @@ -71,6 +71,7 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
>> > 
>> > 	list_del(&shd->list);
>> > 	devl_lock(devlink);
>> > +	devl_resources_unregister(devlink);
>> 
>> Hmm. It is driver's responsibility to call this on appropriate place,
>> symmetric to resource register. Why to have this in code for sh?
>> 
>> The idea I had was to have callbacks to driver to do things like this
>> and more eventually. Would it work for you?
>
>for driver stuff that could be useful (say, someone wants to have
>an additional data structure to iterate and free), OTOH, each
>entity that is sharing should "unplug" from shared devlink, so
>those structures should be emptied anyway
>for my stuff in ice I managed to do without destructor
>
>coming back to devlink stuff - all things (resources, health)
>would need same cleaning in all drives, so putting that in
>devlink_shd_destroy() will simply take the burden off devs
>(at the expense of less symmetric code for normal/shared
>devlinks)

I think that devs can handle the burden for the sake of symmetricity.

>
>in short: I'm ok with any of
>a. callback for all cleanup
>b. callback for driver-specific cleanup
>c. no callback and no driver-specific cleanup (until someone needs
>   that very much)
>
>thanks!
>
>> 
>> 
>> > 	devl_unregister(devlink);
>> > 	devl_unlock(devlink);
>> > 	kfree(shd->id);
>> > -- 
>> > 2.51.1
>> > 
>

