Return-Path: <netdev+bounces-271973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CJYIMkNxWkI6AQAu9opvQ
	(envelope-from <netdev+bounces-271973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA6333A56
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4203230730A3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB550396D0A;
	Thu, 26 Mar 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPVG1VLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AC3C13ED
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520771; cv=none; b=G5ud6pOJpw0zZzX9PlEFohNf6ytW9VWjytRWys1Z+Z7gFtYU9PeTZsFa6zmPCBcydUiZjQSzucJDSboO1nakFSdWd70jlyriUSd7JflG2n9f6LmhoR860pUW79gw8opbJPz9D3eLe6pA1y8KktTAl8sWg3KqDb3hr1JOQuqWZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520771; c=relaxed/simple;
	bh=OsJNSK3Vqae23Fdd0htdFqcqyByWndsGk15G5ve4+eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoZz4JvDm+KyKb9wPZc3VFqc+3FbKY8dSjkTNgHH0H6I0YkbIpXixciz1grhW0CfTqSCwukGu1ZSrtU1Qq5s6tYHeIQPx6UpalXbh1XsPs04REE+enUkFkL+DtkVIWwS9pOZna6Y+o/7iB8n434uboNF+vfF6Ecu8CFfgvX+tYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPVG1VLl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48371104ffdso1280825e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774520769; x=1775125569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w21MILqtQX7tm3Tp3FSO4ZH4iaGfvegT/Zu1Ld8yyR0=;
        b=cPVG1VLl/Qt2+MjfWmKQnNXuOG/02tBLOdZtj9OUFzN/WSA7xtWY3pngNrA5NMjPpu
         HY3dx+sUKqFVTcBsgbITrdLdGyu/FPeGC2p98DA2qAUYMKGcCi3pgatku79KDU1W8zro
         8ebEChblzD1zRVZm931Vlh3umcfWMrtS497fsG+uJaWS+MbALDZUT6LwUmtIeYRma/K+
         fwEMg0ZywG8YLW0bL23Mh4AJDhe6ZTn5Mjd1x8Oe1jc0/KLLIhTuWMskTr3YIwVbAO9V
         mEoBC4r8TdF5Z8fG5Ti6RdqcDLrDT/+uCIAlj7PP6JrRmXNa0t27feuNofR6KcfE94xC
         GCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774520769; x=1775125569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w21MILqtQX7tm3Tp3FSO4ZH4iaGfvegT/Zu1Ld8yyR0=;
        b=AGdrttrZRLDG/vgSZYasCdjMj29EjblVAleRh3b3XsfZdrdm555TeqB7YHkOb2XXrt
         5LIpSYqtDImSJDhMydf9YkbQkfii1q71jf6nlzp24FhSP+vCQQ0REWNUmhlqTWggrOqI
         AUw8JC02tFgat7F3QDOjXPhRisSis11ER91B8vXVFwRzqqq6JguWr9WIng6/ICAqcI3J
         j94KH4O+/TrjEFu+w/kp2/dj88tJ7XXV7Sz46d2I4XfQEPz4DL1yZ2h1w45GKVffO/72
         efLlmE7DN3LJ5K6Eovc8vv875IHDTl30yyVJudU8wY0gSfmZiTZlvMUzMOhjeqHmA68g
         tAsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmX6T018eDBqlvCVOHqiu3SIAYtBf45GdTMMwDLl+QuZ01cQB5lkTmsv+2Agt930LB+cN0t7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzg5BTdjN97M6oEkkV1im/IJzNbW5+6+YAR3esM8ef1nzzS9tQ
	ea2ybVMMilrzYV+1fTDHNn1HfcG7OmzsxSG4dfw3yH3folHkdSWPx+/r
X-Gm-Gg: ATEYQzzt7lVnCiK0Euvz5SYgg7sOKDaujwNpQKmTYk4Q0AcigxVPUhfBfHj0xTgzqG3
	X9Raxu6Hb865dqJjLFgdfKgV+tXTcVRWydVZDRdoKn4/2QFgC9Ss6msbUI8vGkbaZ5jbUZQUwA9
	ESqAXorFfVtSj/K/QovxshoY9CSnFAmZjUjSMRvR+puoS8hExb4gKCRfFgCRmHvylRldjji5UfM
	fZm6tDxv+0jk4tqRv/JtiItlGAVuhSCj09z70uagd3cygmrXCVu7ysNftBtEoLSUgNhWjTWm92h
	C3SqtDcNe1zLrTQ68ew7k3VUTAEQKpdftSPuraSk/xfcxFEEKjmsPndOFzuIwsouAr9V1pwzM4R
	m3ir8iQeigEi49uCtm4eDnHuyDMV/jySXNsgg2BiT85A0YIVAkjrtCLD0qICc+bdEqwy6KfOqIW
	lDl+nV0aDyQKixD+Tb7L4eJblGYg==
X-Received: by 2002:a05:6000:471c:b0:439:c122:4fe3 with SMTP id ffacd0b85a97d-43b889b9d54mr5592527f8f.1.1774520768577;
        Thu, 26 Mar 2026 03:26:08 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm6875026f8f.37.2026.03.26.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:26:07 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:26:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 4/4] net: dsa: ks8995: Add stub bridge join/leave
Message-ID: <20260326102605.krboxk3re5hjcggx@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-4-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ks8995-fixups-v4-4-989abba8f077@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271973-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08AA6333A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:57:35AM +0100, Linus Walleij wrote:
> Implementing ks8995_port_pre_bridge_flags() and
> ks8995_port_bridge_flags() without port_bridge_join()
> is a no-op.
> 
> This adds stubs for bridge join/leave callbacks following
> the pattern of drivers/net/dsa/microchip/ksz_common.c:
> as we have STP callbacks and these will be called right
> after bridge join/leave these will take care of the
> job of setting up the learning which is all we support.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

Yes, but there are important differences to ksz_update_port_member() too.
For one, ksz_common keeps track of which port belongs to which bridge
(dsa_port_bridge_same), in order to separate forwarding domains, and
ks8995_port_stp_state_set() doesn't. So I have my doubts that the
complexity of the driver is currently sufficient to behave in a
satisfactory manner. If lan0 and lan1 were under br0 while lan2 and lan3
were under br1, I don't see what would prevent lan0 <-> lan2 forwarding.

