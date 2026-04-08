Return-Path: <netdev+bounces-276372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNgzBlgZ1mkxBAgAu9opvQ
	(envelope-from <netdev+bounces-276372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:01:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B44293B989E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55ECF301910C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F73AEF55;
	Wed,  8 Apr 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="XN0WAFx7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0E3ACF06
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638856; cv=none; b=L/pqU0TfnTSySV7Q8omz0hBy9nfg25tyqxPjSX7zH5vOad2Z6lERrkzpXjCFkpwDQ6kcVD6ThGNatt4LhJVOoJjuWLZS3aPMZp95TUN2anDJKgYsbdPbyIoAtJeIkAsrEE2bnIb2pzJJdoWHFwAcoh6ybb0CT1j0qSW7AIL8yTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638856; c=relaxed/simple;
	bh=ELi/SO9fCpI1hT2A641r7hbEx4I3MBwqp1WHI9r62rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4w29sa0OrEur+LFPXo97ybNkR3T+FJa2DJCoyphC67ORihbesoE+TjYYvtyNQpGrWGg5S6tw3bKZJ3Ru+ExLj9mrzqbIZsS0t0pRBxPNi2SSEqOsauCBzSG/dVL6mZfpXo04mhnbN7NuzwgKUZtwL4SqenPAXH7F4qK0cFfo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=XN0WAFx7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43ccda008cdso386170f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775638850; x=1776243650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELi/SO9fCpI1hT2A641r7hbEx4I3MBwqp1WHI9r62rw=;
        b=XN0WAFx7iG2ftBhZlqE8YxdKg5MkMfcXVGxvTiQAZvedNftcT4gpsHai3OmsSWnqC6
         oksBoua+/JA6huk1vAdcKfHnXxlrm7cR/RRY91thyWtBZ8WD3WIUW+CC2hH7k4pmbZ0W
         QVLaElUTxH1QLJeH2TAs//CHuhlN5YZsA5Ffd2LLic9JhESvMlJLJ2PfvnHHYtdT8hq4
         EWH39QXNg7WcP+YhBiI82SmNTJCbuxHUX01cWNORucglEV7VnOK5MYL0c2vTU0hPi8cc
         D8cR6bRrA1g0AjI8Ucirtsp/I98dzAD4sPjv0K2Uf6+etneJVOML4BsawVcZYjXqlf1L
         Veag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638850; x=1776243650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELi/SO9fCpI1hT2A641r7hbEx4I3MBwqp1WHI9r62rw=;
        b=M4KKZINhmDeFpGQfc3JnowSC/FQrq91+9KgAsz4gXlSdcR3NwkLLDxzlW8RN15QRjw
         yTkHrDJNFwRBNxu3jIcLZhgC8mn9qQqJW+Fq4Zl5HLGdYhLP09uTU+z1G9wa+0wPkK+O
         uJJFsCOo3pfM+WTe/L2NYmBnPSbJ+fKEhOPnXvqwArZZJfjQ+n9Nn1ORQ85gsi18cK8s
         lTuaFLnIiA08mGmqPySafcZcnsdyRNHFvqRJrKOnAJLYH07Flw/zg+mNAw+VId4KwtZl
         W4UQQCPZxuiUbTPYoEJD4GDEE0/bef3mGu8mJp7ZkKVkMq6iqJyBdNi4C7cTzY8fuFQQ
         9kjA==
X-Forwarded-Encrypted: i=1; AJvYcCUE5ZG1WtjXO2Ipy9GpnlU3BkqSLeBROyGvZ78JTVYYi+7PjmLgs8TX+7ouHj+MHv9BcwqT+Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrkF0JV/qRhNQcv6tSzMANa/PX8gXUS4xkPXAF8JJUzXl6icC
	5ElX7Z4zyPWDmRh4gE0l9Xmm5ZFv/yfsKTxIS8DQmMBqVIv/VagizS0eXak20mjp6hDLCraMxax
	+hlt9
X-Gm-Gg: AeBDiesu5JemZxyAg03Zd/Ibby8tAGriFW7Ha2KxNo+rnVwxhVEI60gUulytWeTaDSx
	XlGIjoCFSluqi34kVrSFnv1BgvSm24XoH5Iceu3rmjKJYYp54N5b2KEBcrS68urXnklbBhncGfR
	lrw2iDowVO0/GWt7/9z6XcsgRixfRp3UIRbvFeyN0ki+uoCZ3FhUGOzg3wv2Sn517Oeo6SN9uSx
	Yn838F9oq7G2gQHV5Lkse/PkkYqmVbQKCrdZG7lev6tv7e4bf6OH7lIWiBIKEY79smMrTONTs9X
	GTA0rKw9EIDB+bAPDdYubDOsmW9yeIgmeAD5hHFjYx6EFnVxVrDSTC49MkHHdEsLO75jSzhsOZc
	xM8GBAt3II9Bfaq8uOwvmQk+S9QT8wirw68ArHj7bwSl0bvHN5i+ytt3muDYfP4ztCuXnkkqF+v
	I8iW2lUicF8ZIApoZy8ZrRyyzozTRvv7Q=
X-Received: by 2002:a05:6000:2384:b0:43d:384a:9e96 with SMTP id ffacd0b85a97d-43d384a9f5amr19228181f8f.4.1775638850006;
        Wed, 08 Apr 2026 02:00:50 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2738sm58262922f8f.24.2026.04.08.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:00:49 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:00:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
Message-ID: <iuhx4kkkftjx52y5qo7w7p6rbxqakq2eu74r66xaepd2p2khjh@kdhljd2c2bpm>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <utlz3oebjyd4lqp5pd4qdbth2kywxo4hrlrnwcxsx3br76fwfg@vy3tx5f3lv32>
 <CANkEMgn80UM7+mymVm21Q8yszgVeh029tvO+kHqmLGmf-2MU5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANkEMgn80UM7+mymVm21Q8yszgVeh029tvO+kHqmLGmf-2MU5g@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[resnulli.us:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B44293B989E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Apr 08, 2026 at 02:12:35AM +0200, marcharvey@google.com wrote:
>On Tue, Apr 7, 2026 at 4:55 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Apr 06, 2026 at 05:03:36AM +0200, marcharvey@google.com wrote:
>> >Allow independent control over receive and transmit enablement states
>> >for aggregated ports in the team driver.
>> >
>> >The motivation is that IEE 802.3ad LACP "independent control" can't
>> >be implemented for the team driver currently. This was added to the
>> >bonding driver in commit 240fd405528b ("bonding: Add independent
>> >control state machine").
>> >
>> >This series also has a few patches that add tests to show that the old
>> >coupled enablement still works and that the new decoupled enablement
>> >works as intended (4, 5, and 10).
>> >
>> >There are three patches with small fixes as well, with the goal of
>> >making the final decoupling patch clearer (1, 2, and 3).
>>
>> Looks fine to me now. Do you have libteam/teamd counterpart?
>
>I don't see a need for this to be used in any of the teamd runners.

Why do you need this then?

