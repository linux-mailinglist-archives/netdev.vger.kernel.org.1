Return-Path: <netdev+bounces-277051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP05DObH12n6SwgAu9opvQ
	(envelope-from <netdev+bounces-277051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:38:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F13CCD5D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB08630306E3
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190363E1D06;
	Thu,  9 Apr 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+meXiLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF963E022F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748620; cv=none; b=X4AlrIwSsMp7PpQdFXOe9/CdbEK0e3VIvjdijww/oQp+a6ShS7Q97vIKnyWE4Ufpa4PQnyJ4PyQ3gMlReAqSBL0R9SkYEiCbRPWWzxingOJZmOFzsaxbCQnfn7HLL4Hv0wo7f4Jm7Nqmseoqe4I9VwLIpQWW/bEFs5mCVv+rzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748620; c=relaxed/simple;
	bh=sFdD10WcpWg9ctZZ86Gdjst5kbYUzSoaoOH/yor5REI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvGs/4y1p4GYIQlXDRyX+t3K0dAKtvQsjcKhTgWOxDDueYwCi2/eUNi+lyuJTLpImWuyJWkdSf6WDieC/M0oAak4MMA5yUC1+d8615Ab2V4/mltuQR1ZWI1FDlI1wkRIrjHihFcv0pNuhHdarhcyQHCIJhU85SguE4T8PqDKC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+meXiLm; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-40ea611d1a4so473895fac.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775748617; x=1776353417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZwiKxiIbtGMhXg/CvDhDvgIBLYlxu7v0Y8bldp2nvI=;
        b=b+meXiLmesx1adS2mriVn3/nLUIFEy1Av+skYpy2XKoJkcwBootx467Pzftb9axpRM
         bH0xFLTfrYiZu4tWV17JvqsSPxB5NA0tmY3c4Nkzc/nYAR4IxCgdCOk/V0Fzd36K24jm
         i7QIeBa/kalVB8e195Q5m071dG5JK231/UT8YTODW9B07NCqReYoU2qynfOYlebZavui
         spS191YK2r9M82IR1U1Kv/+6TR9+TdjvDQwgr3CM56eRlK0vDcm2VoO2YhPMmaRF2un/
         Ta/QyH8uU9halfTSovbx+k4/d0uc1qgiKIstlB51gB8IaTGdcVLHApzBOpu1lhXtqSje
         HmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748617; x=1776353417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZwiKxiIbtGMhXg/CvDhDvgIBLYlxu7v0Y8bldp2nvI=;
        b=B6/lY2Q/vIPgwX93okow7ru3ygEa1vSsTiEkMx0vv2tJYCyp3ERELbao1m7owE+kyS
         vRCic5vbQXCKDw99bsel8/ekV99TZSSL83S+XauhDvro1jYhxEZ7MBgSNLQuTTkl/7YG
         Y7lS76Oy2G91+R3wbWIG3Sigs3lST6iFkvLeMsQvFtIo4vXLNVI/ug/pRnDx9H4Ln+9A
         zaBW9ZdZQNI+TUhmxE7TerM7k2y8iom7QKXLsPalhwbt0TMKhgX2WkMdcAcrjT3EdRs8
         8DQj183Zog1XD4MkuPENL2Em9GnJk5T0ZIgp/1KaZF/7PkboGWraM/lalg6Z23Hpqa9c
         IaaA==
X-Forwarded-Encrypted: i=1; AJvYcCVCd9jwY2R9PD4ymXga/xhEzxKbxC0x6QYzt/j4yY5XdXQAe7/g0xlWQjwZiwAAUM1Ld+J2yMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3bWjsURo/3yK6YnAYda1YZzaALla2uph6mrJSZHMVBAKaqfx
	YNoq01+bsFjm9G4xmTnwC6OHPZQZpbZh7VZKInxRAQmx0NCREibLjUaqC9z4Rrt6qWg=
X-Gm-Gg: AeBDietl4Yq1j1Y9B9S85A3yuMQBDTyzSdwOexp26efmakMpZspdzeuItNZ2SsBorqd
	3Z5NtiGhnRKwSmxHzlD1hIrxNzTV0uOYZOlgrcR7lBvwhNz/PZYTwixUCykFDl9vxpAG2RNe9Yj
	fkoAtwAf5+0oJks2OttV7E19QNnim1snCN0/hP/JRROGtJZaQLnMYvk0bWbh2Gp2ZfRuslFW5jD
	Oxu+SHy97LLh4vzGE9JjbJuv7Z7L0MUOxcX9IlarGhVyE5fhs/zSg5jQGCRhHEBTsGq0J3laGls
	m3OjYc16SzjoMoFPeOw+T0Xqn55m1mWd6cGOdKkAGmX793WHFxiwjwazOOCjRoeraSHhQrxoRPZ
	INec62buewJtU2x4papITY4iCmC9FujaHj9z5wZ0o5NcIpdZLZfEli61NeksgP/gOXjYPHfhypm
	DbnihfyxI/nVy5PXCMNg==
X-Received: by 2002:a05:6870:8e09:b0:3ec:a08c:9707 with SMTP id 586e51a60fabf-423bdd1f870mr2725214fac.42.1775748617420;
        Thu, 09 Apr 2026 08:30:17 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423b34e8790sm3345666fac.16.2026.04.09.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:30:16 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Thu, 9 Apr 2026 08:30:16 -0700
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] tools: ynl: move ethtool.py to selftest
Message-ID: <adfF0crehpManDBN@devvm17672.vll0.facebook.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
 <20260408-b4-ynl_ethtool-v2-1-7623a5e8f70b@gmail.com>
 <adaFLI2b5eb2mZHx@devvm17672.vll0.facebook.com>
 <20260408173716.0dedf22c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408173716.0dedf22c@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277051-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C74F13CCD5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/08, Jakub Kicinski wrote:
> On Wed, 8 Apr 2026 09:42:33 -0700 Stanislav Fomichev wrote:
> > > @@ -8,7 +8,7 @@ KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests
> > >  source "$KSELFTEST_KTAP_HELPERS"
> > >  
> > >  # Default ynl-ethtool path for direct execution, can be overridden by make install
> > > -ynl_ethtool="../pyynl/ethtool.py"
> > > +ynl_ethtool="./ethtool.py"
> > >  
> > >  readonly NSIM_ID="1337"
> > >  readonly NSIM_DEV_NAME="nsim${NSIM_ID}"  
> > 
> > Do we need to add some expects/asserts to the script to really make it into
> > a test? Right now it just prints things, so it's not really a test.
> 
> This file is full of asserts? It's a bash script that runs ethtool.py 
> and checks the output. Which one of us is missing the point ? :)

Oh, yes, I did miss the script!

