Return-Path: <netdev+bounces-48333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D37EE170
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0241C2095D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1828130659;
	Thu, 16 Nov 2023 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="SR5uvBfQ"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1C19D
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:21:37 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGDLP1k3638490
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1700140880; bh=kBcf1cQK+wAWheHU+pk6HOyMrI6Glc2gLtYPSvODSTI=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=SR5uvBfQwGShcLhkkM6pBw0GBTEQo3cvLPZTMhi9CJAyG2MP8sAYHJ+6hKnOjbAGO
	 NVA3Xynu6Z6GOeTzfA1CzAfb9VMlf+7pX9Sa7rbi1Ku4CZgMeQfNSMG3icyWbdvqHH
	 1vdOYIyDPjUl+6/l4InebM7cUBHeRKCKRyzU0G60=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGDLKg33957419
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 14:21:20 +0100
Received: (nullmailer pid 2276260 invoked by uid 1000);
	Thu, 16 Nov 2023 13:21:20 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC] usbnet: assign unique random MAC
Organization: m
References: <20231116123033.26035-1-oneukum@suse.com>
	<87ttplg9cw.fsf@miraculix.mork.no>
	<774a8092-c677-4942-9a0a-9a42ea5ca1fd@suse.com>
Date: Thu, 16 Nov 2023 14:21:20 +0100
In-Reply-To: <774a8092-c677-4942-9a0a-9a42ea5ca1fd@suse.com> (Oliver Neukum's
	message of "Thu, 16 Nov 2023 14:02:47 +0100")
Message-ID: <87il61g7fz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Oliver Neukum <oneukum@suse.com> writes:

> On 16.11.23 13:39, Bj=C3=B8rn Mork wrote:
>> Oliver Neukum <oneukum@suse.com> writes:
>>=20
>>> A module parameter to go back to the old behavior
>>> is included.
>> Is this really required?  If we add it now then we can never get rid
>> of
>> it.  Why not try without, and add this back if/when somebody complains
>> about the new behaviour?
>> I believe there's a fair chance no one will notice or complain.  And
>> we
>> have much cleaner code and one module param less.
>
> Isn't it a bit evil to change behavior?

Only if someone actually depend on the old behaviour.  And I think
there's a fair chance no one does.

I don't propose forcing this change on anyone.  Only to try and see if
we can apply if without any force involved.

Note that the module parameter solution also will be a breaking change
for anyone depending on the current behaviour.  If you want to avoid
that, then you need to invert the logic. And then you might as well drop
the whole change.

> Do you think I should make a different version for stable
> with the logic for retaining the old behavior inverted?

I assumed this was unsuitable for stable backports.  Is there any reason
to backport it?


Bj=C3=B8rn

