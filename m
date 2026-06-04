Return-Path: <netdev+bounces-295166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q2dQJglTIWrjDQEAu9opvQ
	(envelope-from <netdev+bounces-295166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:27:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87163F016
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:27:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=DNCS45tC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295166-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E8D3019BA9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807B3563EB;
	Thu,  4 Jun 2026 10:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F4342C98
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:21:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568481; cv=none; b=LV9OkrGYOCpEZho0T5N0T3mrmXMezu3ZcZZl/BLQQ2yCPQc16f8+JKrLDsgOFEda9krzzSZ/Y4Nv4CMEkHRHYo/MA0pk2r0atXOZZ89l8RFxjnpmNzADDl6XVvITpAoHbtV1NkL0nIfQEp6B9cyRWae7SVgSzCLOdngssSagB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568481; c=relaxed/simple;
	bh=j22bdv9oPvFnjlSd+/YWy+aZ8pdIVUE4JTKplAf6Lg8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LGif24VztHGRibZnYecfoxZRNtP1q9HRnC92i1q3bVl7smwkYD/SZ0rLVA+Wa4GZ8oJoiF1HQ+5SKiIEG997XO5rQFwgpD3zqhlLGsdPyDYcCWG7qUiHC99ealO6OBkAM6JDV2bca16XWzdAM+VS6ikvE6DiAEJEmIy27hwJr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DNCS45tC; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD42AA4C55;
	Thu,  4 Jun 2026 12:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780568477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eXdVtjcOydMZf6JHfGJ2qYRXGk9C4bzSq34+tbFiQOo=;
	b=DNCS45tC1g/hdn2LEdDuSLmFoTECMMqjQCXssdm2wbAYK/RkLBJRNNxJ+fGSF8ux57NRXV
	0U4M7wX5yemBoeXemxMvOUzF9cyDe4CwYJ9qh8O+ffCPFwJjZflbUj6Ml0N7pNlf8rUT2f
	NCegmc1lEb1YE4beocYUQltMREhsvEdwf8TRMxhwdXRROZDETyVv0msec5XNtlN0GOnVc8
	oJ438HfGi1eF5mFW+q+LINFnj9hPj4z4u5kYn6Y7Ye6NPJ9mg2DDyVq5GkJ1W6eonNCBHo
	50MdU5AMW7bYzNFXatyHZR2dzXv0HSH0kBdPGRoL165cu+irZJd3+1Ruh+YEKw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 12:21:16 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
In-Reply-To: <3ca7d6b6-1aeb-4e7b-9263-64f4b427d1ef@intel.com>
References: <20260603210810.2636193-1-kuba@kernel.org>
 <508a922f-c8e4-4b31-8670-43d44d45f467@intel.com>
 <20260603163518.7bde747a@kernel.org>
 <3ca7d6b6-1aeb-4e7b-9263-64f4b427d1ef@intel.com>
Message-ID: <191ecbc0a4f9b51b9ead8ba559d6a170@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF87163F016

On 4.6.2026 02:17, Jacob Keller wrote:
> On 6/3/2026 4:35 PM, Jakub Kicinski wrote:
>> On Wed, 3 Jun 2026 15:08:46 -0700 Jacob Keller wrote:
>>> Hmm. I was a bit confused at first by the switch from safe_load to
>>> load.. but we're passing Loader as _yaml_loader which will either be
>>> CSafeLoader *or* the default SafeLoader, so we'll get the appropriate
>>> loader equivalent to what safe_load would have done, so there's no
>>> change. Ok
>> 
>> Maybe I should have mentioned this in the commit msg. I was also super
>> confused by these APIs but IDK how much is this me not knowing Python
>> and how much it's special. AFAIU basically:
>> 
> 
> This is a pyyaml issue not a generic python one I think.
> 
>> somewhere in pyyaml...
>> 
>> 	def safe_load(file):
>> 		return load(file, Loader=SafeLoader)
>> 
>> so safe_load() is just a "shorthand" for using SafeLoader, which 
>> unlike
>> load()s default loader doesn't allow constructing real/binary Python
>> objects ?
> 
> load() by default uses the generic Loader that supports the full spec
> and because of that is "unsafe":
> 
> https://github.com/yaml/pyyaml/wiki/PyYAML-yaml.load(input)-Deprecation
> 
> Basically, loading the full YAML spec on untrusted input is unsafe 
> since
> it allows arbitrary execution.
>> 
>> Why it doesn't default to the C one is beyond my understanding.
> 
> Right. I'm not super familiar here as to how it ends up not defaulting
> to CSafeLoader, but probably its because its not always available.

That's correct. CSafeLoader is only available if libyaml-dev was present 
when
pyyaml was built. Auto-enabling the libyaml bindings was requested a few 
years
ago, but it stalled due to internals [1]. It would also require 
reworking
safe_load() and others, which are atm hardcoded. Hence the usual 
try/except
import pattern.

Anyway, the changes match the usual patterns.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

[1] https://github.com/yaml/pyyaml/issues/437

Regards
Nicolai


