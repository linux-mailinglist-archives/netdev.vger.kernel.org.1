Return-Path: <netdev+bounces-297608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1dSWNQJBKWo2TAMAu9opvQ
	(envelope-from <netdev+bounces-297608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:48:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94466686DA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:48:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=O72aWOTX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297608-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297608-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB320301C933
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED753EEAFE;
	Wed, 10 Jun 2026 10:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821133AC0DD;
	Wed, 10 Jun 2026 10:36:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087797; cv=none; b=cQxxSzWfiYxm9Y9jY32tfkp7svA8lS5I1CzI5Fn7MXqYlpCteBZf2Rrv7GynVogqhhbFD3Pm+QMzd3Lv68hdwn8TT+KCW00F8kgjHNjVwMVDQ74RRTW9+QE/u7XxuLkR/PM7/9V5OW587sz2IZiVRO1quPgYr2fg8o/HgTAOS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087797; c=relaxed/simple;
	bh=sxojESLRIAg5WSIqEGLuDfTZ3dllHbFSpRiR8XKzC1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZfDpT48EyTqHeoxggAEQLkFMqvVl8+7nz2VXw3J/tARp7bNWxVeIqA5rr3R8qJi30YRtfTnUmggiWGJA/eUAhsF8XF2Zv6qQv1QncX7gJ1ZLM7zSQ3sXqfdGXWT9xbhANSBNnqrtnTFrDf0A+YZU8O5+0G6NiaFZS2ss1Jp358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=O72aWOTX; arc=none smtp.client-ip=212.227.15.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781087787; x=1781692587; i=markus.elfring@web.de;
	bh=fs8Ok3+cTNIYrAHYO5Pmt1zk9BZvwgmOOfLZc5NDLaQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O72aWOTXuH/rcUEdH2KO0of1Ey5JQadlnowTewj60ou8m98hmdclzHtc+3FOHxyZ
	 x6TDkVYEZsrqUll/VKw66j00HY953zHG4EEaT3L0C6/sQ3AaEwM6RtyGBSYEGUsyv
	 jQcRAHZywq8lOQXJ7e0A3UFrcY6EO3/yMvSunpJWnPeIc9Q8hR5KhdqTRIkTd7dPa
	 GJYhROEiAJgGlihHgvcAtcwj85cZg9eXwQhGt1PVBelTkng8CHIDF+mknwPimtO8p
	 G6vCkDfTgJCsap1b4BnCdRWuO8nA/rvJm8bxKrt7VS1o1GzFfl4K9Njsdb3EKy2VZ
	 Z+nGhGcKArqtiFsFRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1wei1O1e7Z-00Klox; Wed, 10
 Jun 2026 12:36:27 +0200
Message-ID: <0789aef1-4173-40aa-94e7-576b73ad0201@web.de>
Date: Wed, 10 Jun 2026 12:36:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] i40e: Use common error handling code in
 i40e_register_auxiliary_dev()
To: Manuel Ebner <manuelebner@mailbox.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <f0b4e354-9ed7-43f5-8ffe-97019e421c02@web.de>
 <c80c7ad9aa48dca8799ed2e76b1628aa7bec92b0.camel@mailbox.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c80c7ad9aa48dca8799ed2e76b1628aa7bec92b0.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HhgeNHSkXEWFo8b3gYoOcOL+xPlZ1naCif/BIU3aNj8MlB3bEfU
 YAZiLR1sETCCrWPLtisMQednRbzkFaYxiZHFQntZKYeOYzycpN9oVXGUIn5UTKoFfCP023D
 LoDVISGal9DouXa1sGmsCLk83KmY9OCy9AqMYumPJjjaom18PzvYEXmtpcC4pMEwQy3x2IP
 Fu0jUoKMeKRHNLjV6C1yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:67BW7pd4GZ8=;Va1f6rwrb7apsVAhnpn6Rb595nf
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297608-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,cmu-sei.github.io:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D94466686DA

>> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> @@ -304,15 +304,15 @@ static int i40e_register_auxiliary_dev(struct i40=
e_info *ldev,
>> const char *name)
>> =C2=A0	ldev->aux_dev =3D aux_dev;
>> =C2=A0
>> =C2=A0	ret =3D ida_alloc(&i40e_client_ida, GFP_KERNEL);
>> -	if (ret < 0) {
>> -		kfree(i40e_aux_dev);
>> -		return ret;
>> -	}
>> +	if (ret < 0)
>> +		goto free_aux_dev;
>> +
>> =C2=A0	aux_dev->id =3D ret;
>> =C2=A0
>> =C2=A0	ret =3D auxiliary_device_init(aux_dev);
>> =C2=A0	if (ret < 0) {
>> =C2=A0		ida_free(&i40e_client_ida, aux_dev->id);
>> +free_aux_dev:
>> =C2=A0		kfree(i40e_aux_dev);
>> =C2=A0		return ret;
> why do you do this? There's no functional change, right?
> is it just readability?
Please take another look at corresponding information sources.

* Centralized exiting of functions
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv7.1-rc7#n526

* https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-stan=
dard/recommendations/memory-management-mem/mem12-c/



Would you like to increase the application of scope-based resource managem=
ent?

Regards,
Markus

