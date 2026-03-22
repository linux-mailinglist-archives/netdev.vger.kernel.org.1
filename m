Return-Path: <netdev+bounces-270328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNliLY92wGkwIAQAu9opvQ
	(envelope-from <netdev+bounces-270328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 00:09:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F12EB200
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 00:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD313008A7E
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3936E478;
	Sun, 22 Mar 2026 23:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2802ED848
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774220941; cv=none; b=sU0mcEFCn0nZnfhW8I+w1F/VE82Bo0iAfqDgfkYM5OgvO9g7WEkdjG/3Xc0MAYTL0mblw5ltMgem0LUKOwCy/QwnIppKM1qX7hizYGWrLl9IlQJeE8K/LxsFs9frFgZe0EaWwPYr7uGjHOBdeEX6mSRnlzbGclQkkGJ/Av9CWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774220941; c=relaxed/simple;
	bh=ln1FsL8a/sjtX9+cnCkUgpaW92A41rQNplN1E9B+3HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYKZjod294FI3rIdcmGHSe7owntxu/dPWnM423a7QLPd9oce/+nCtLlWWBAyGY0TO9shfsH3p2ai4oufQoLKeWKyZYviNGO3D1UONGfy16DCZKosgZ1oyU8uzdEYcGEudDatiKSXWhCQ8/F5gdOA0RMxHs92oyjrKlBjJoMMomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b6d9c981so2457007f8f.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 16:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774220938; x=1774825738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKjk90zLlJLtFb5uv6zbpADQTbtU71ATu76Om9DzCMA=;
        b=X4Axa5OdUL1/Vjei90dvXXW/jOTFNmb4iEq+sgt1Jc1tT5iWXAfhql5hUKIqrqCSOS
         IS2HvwBuSmGCzyMczGZFKjji4OXibqn4CwXv8gUA8jYSMoW1rlZV+UAyvZ3rc0jqbPiy
         AN6l2Qv3LOau2aKJEcOvbV/6z2NwMtXLtH1z9wkS+f9QmIC2uo4PXILxVjqoVhtTNb7w
         mqIDC+vzbVp3cNKoqa2pauqHBgsnvyOOBXNAyy0iB62nYumbEuyd0xILKj4TmqBYrUuT
         T13niFhedjN9+NEhuiIav7PL5q1KDzPZKzgV6Gwye9d7bnHziGF0ncsHbI68zd3abJDp
         hvDA==
X-Forwarded-Encrypted: i=1; AJvYcCWVs0JoEHasqMtTs1fZus6WeAcIWz0gihahZwC7hyMbzoFToR8LyhGqX2MkFdEV31F/ocCpjyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs21nvpnXi9MIdBP75Z01TFoYhfbOa/GHOwfdoOWG44dT4AU8w
	5nmcwXdBzhNDsZIC7m+fU3vg5ErpeWj6MhxAfKWWy35fGB4RHYaa5Hvc
X-Gm-Gg: ATEYQzw2FPZ6jLZNb6rrZJn2wix2pl8PXWSXKkNBO/H08uF7gG81X2tWEiSWVVF71T1
	G1Iv0pDG3GJSCzd7I9H8ITfk/Mm+FSDkZbKqOREP0fY+LQqww4hGhgDY9q7X4SwPnv4U+mjFMoz
	jKsXLkdOu6YlI81XIIkE6YvmutfM3heUbSkdxfx3W8Sz7jgxTQZ55q/Y90ycR2bj3AY7IoyAAKj
	JEVLrryg3sIbcYApX5DuFDx8Ja0cNHIvtFS7XJjrNYkxMlKv8AAUjPPe0viFkZ7ZQz1Du4Wxdrf
	54WA4GpKIkdlHZnWS5DV05ByX6oG59GWHgK3e1Vyqy4cNE8tpZ++KDI2oBJyNG6FN22OiAUTQR9
	YUFUZU2VoeYVSywvRGwSCU5ZkKvOYOmDnI5Io3u37t3HS+6hMg0TXpbeQAkfs1/he/yhJQcIlqC
	J7qqMWBpp3expXzkE8DTQ=
X-Received: by 2002:a05:6000:26d0:b0:43b:4312:2cbb with SMTP id ffacd0b85a97d-43b64272a9dmr17016793f8f.17.1774220937931;
        Sun, 22 Mar 2026 16:08:57 -0700 (PDT)
Received: from [0.0.0.0] ([94.156.174.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm25191072f8f.18.2026.03.22.16.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 16:08:57 -0700 (PDT)
Message-ID: <eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com>
Date: Mon, 23 Mar 2026 02:08:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] ethtool: don't touch the parent device of a net device
 being unregistered
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Ido Schimmel <idosch@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Greg KH
 <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, notify@kernel.org
References: <20260322075917.254874-1-alex.popov@linux.com>
 <3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
Content-Language: en-US
From: Alexander Popov <alex.popov@linux.com>
In-Reply-To: <3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[alex.popov@linux.com]
X-Rspamd-Queue-Id: 3A3F12EB200
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 17:39, Andrew Lunn wrote:
> On Sun, Mar 22, 2026 at 10:59:15AM +0300, Alexander Popov wrote:
>> The ethtool operations may be performed on a net device that is currently
>> being unregistered. This is also described in the commit dde91ccfa25fd58f
>> ("ethtool: do not perform operations on net devices being unregistered").
>> Moreover, such a device may have a parent that has already been freed.
> 
> I don't know the device core too well, but can you explain in the
> example stack trace you gave how the parent can already be free? I
> would of expected devices are arranged in a tree, and free happens
> from the leaves towards the root? In order to do a clean shutdown, you
> might need to perform operations on the parent.
> 
> I just want to make sure this is not a broken parent device which
> should be fixed...

Hello Andrew, let me describe the scenario that I see:

  - The netdev_run_todo() function handles the net devices in net_todo_list
    in a loop and moves each of them into the NETREG_UNREGISTERED state:
      netdev_lock(dev);
      WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
      netdev_unlock(dev);

  - Then netdev_run_todo() frees these net devices in another loop.
    On each iteration, it chooses a device for freeing:
      dev = netdev_wait_allrefs_any(&list);

  - At the same time, the ethnl_set_features() function calls
    ethnl_parse_header_dev_get() for the child net device.

  - If the race condition succeeds, ethnl_set_features() takes the reference
    to the child net device being unregistered. That makes netdev_run_todo()
    free the parent first.

Best regards,
Alexander


