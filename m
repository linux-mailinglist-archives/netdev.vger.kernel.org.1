Return-Path: <netdev+bounces-292154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cz6LHijFmoOoAcAu9opvQ
	(envelope-from <netdev+bounces-292154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE665E0B1C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E688305509D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E82F3CDBA9;
	Wed, 27 May 2026 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VYVEZxjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5C3CD8AD
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868429; cv=none; b=F58Rh4FKxkbJIoUKd3t9zDFCSvrZNSawiLsmv/KonNNFHET5np+FYskPwg0g+uhEsGYdhbHksHv71eDEBz0cUhZk9C+/fF7xTDONBYbF3aboyG2uWyws8fnAGi+5eBzQ3e1duouyscyryEGT0vEvvA7jpCYLx2R0oR9SBZYUjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868429; c=relaxed/simple;
	bh=LFyioZCTW+ZiNuJCpdoWoxUyVV6b0Xecy4cKfm9Z1Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+NL/sp/t+bI5LwgSuedrZtVdVoxy8ZI0FfVXqc9rAseNQRAmtlQeb6daaQgsWo3aDfBfbdMczfhBH1KDSjsY44PtzlR6FEf9DY1s0LcdnQDIxYl2dF7D2HSifKlmhPJx3alfktmO3y3AJnxByZC0NFA0goyn++Zk0DOQasXKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VYVEZxjo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9FBA21A36DC;
	Wed, 27 May 2026 07:53:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 710AE601A1;
	Wed, 27 May 2026 07:53:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AAD711088805F;
	Wed, 27 May 2026 09:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779868424; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9YBx2gOkZzjwHTBHcOIgoEuKlLYiwrVY86yq/isaziY=;
	b=VYVEZxjoHGTF9UHTe0v6QhbyMoScdi4783k3JqBrP8iYBgKPvg8oHXzy9gzxc+ijkZVr46
	Mnh7v7TstFw4AC5dlbL7+vDH2Gp9EjJcADNPvBpXhETpjmmWUe1OL8xahWEQFaRfd2ZBha
	eJH2m3thL8N/u94fC2W9KcyaA57hS1uskfmVk0s4tdToCV4ZQ+HXKIYlggvLX0vJkprTel
	oCBFhBF0ebYabZmJgkfehp74Mx+NTaTMCGB9b/JFcNY3rszCYsvS1/isZd7fSGBo7AFqyd
	699vnJYTjNDd29K9KuJlkk0o7+z94EcYIZqwOZTt8q2lrvjHyN3WNQoLZjENvQ==
Message-ID: <7bd6c580-8c0c-4323-ad18-84b93c2b61c7@bootlin.com>
Date: Wed, 27 May 2026 09:53:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/10] docs: net: refresh netdev feature guidance
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
References: <20260526160151.2793354-1-kuba@kernel.org>
 <20260526160151.2793354-7-kuba@kernel.org>
 <422219d6-8377-423c-8ccd-641b2fccaa1a@bootlin.com>
 <20260526153532.7979b43c@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153532.7979b43c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292154-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1FE665E0B1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub

On 5/27/26 00:35, Jakub Kicinski wrote:
> On Tue, 26 May 2026 20:41:10 +0200 Maxime Chevallier wrote:
>>>    
>>>     1. netdev->hw_features set contains features whose state may possibly
>>>        be changed (enabled or disabled) for a particular device by user's
>>> -    request.  This set should be initialized in ndo_init callback and not
>>> -    changed later.
>>> +    request.  Drivers normally initialize this set before registration or
>>> +    in the ndo_init callback. Changes after registration should be made
>>> +    very carefully as other parts of the code may assume hw_features are
>>> +    static. At the very least changes must be made under rtnl_lock and
>>> +    the netdev instance lock, and followed by netdev_update_features().
>> Feel free to keep this description as-is, but can we get somewhere the
>> actual meaning of "hw" in "hw_features" ? I've seen this cause confusion
>> before as this is sometimes wrongly interpreted as "Hardware features",
>> which isn't correct as the hardware may do stuff without allowing users
>> to change that behaviour.
>>
>> I vaguely recall something along the lines of "Host-Writeable features",
>> but I am not sure at all about that...
> 
> Hm. I assumed the hw in hw_features stands for hardware.
> The magic behavior of host controllable vs hardwired was
> probably added later without renaming the field.
> 
> As you indicate the usual confusion is that it's legal to have
> a feature in ->features which is not set in ->hw_features which
> means that features is hardwired "on", it can't be disabled by
> the user.
> 
> The current text does say this: "features whose state may [..]
> be changed [..] by user's request". But perhaps it's not emphatic
> enough.
> 
> Main question is whether this series should be clarifying
> this or our criteria is that the series doesn't _add_ confusion,
> even if it doesn't clarify all the potential confusion points? :)

Frankly I think your series is good as it is, the text is clear
enough, and we can redirect people to it if we spot an issue
on that point during review.

Thanks a lot for answering,

Maxime


