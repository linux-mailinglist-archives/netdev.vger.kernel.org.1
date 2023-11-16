Return-Path: <netdev+bounces-48385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584787EE349
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2BEB20A0B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2B31A84;
	Thu, 16 Nov 2023 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="SOWVHMW9"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84FC4
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:50:08 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGEnfop3643769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 14:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1700146176; bh=ro+vBBUDmTdwfshjAPF+0A6TJCUUikg+AZcMI9ZZDqY=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=SOWVHMW9YC2pERmmyqjq7PaqyQLReb9E4HtE/BkYDcHIhr+gpef/z9aPTyg4xRI3F
	 QZGYtBLR2c65qwBI2g0PsfNSK6sqCi4/b4XQvuxvRAU6u2T9M27Tkx9FGHRNRfJxvr
	 OviBzZ+aK+vichiws/oY5G808aW4Cp6nGTMVSbFE=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGEnajA3976452
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 15:49:36 +0100
Received: (nullmailer pid 2277765 invoked by uid 1000);
	Thu, 16 Nov 2023 14:49:36 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC] usbnet: assign unique random MAC
Organization: m
References: <20231116123033.26035-1-oneukum@suse.com>
	<87ttplg9cw.fsf@miraculix.mork.no>
	<774a8092-c677-4942-9a0a-9a42ea5ca1fd@suse.com>
	<87il61g7fz.fsf@miraculix.mork.no>
	<6eba35aa-c20e-434d-9d4d-71c1c06c7a1d@suse.com>
Date: Thu, 16 Nov 2023 15:49:36 +0100
In-Reply-To: <6eba35aa-c20e-434d-9d4d-71c1c06c7a1d@suse.com> (Oliver Neukum's
	message of "Thu, 16 Nov 2023 14:29:43 +0100")
Message-ID: <875y21g3cv.fsf@miraculix.mork.no>
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

> You could argue that handing out the same MAC twice
> violates standards.

You can't argue that to the Sparc crowd.  Which has to be considered
when sending stuff to netdev :-)


Bj=C3=B8rn

