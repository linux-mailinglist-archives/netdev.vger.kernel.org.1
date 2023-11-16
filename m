Return-Path: <netdev+bounces-48321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBE7EE0CA
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCADE1C2083A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD135A926;
	Thu, 16 Nov 2023 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="CHHu6uC1"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313FAA1
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 04:40:16 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGCe5k43636085
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 12:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1700138400; bh=dBqLE9y2FBSN6FL5kpLR5wOAC87t7Edvc/uqTAw3cdk=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=CHHu6uC1CACUp+ft2fiz6XMUh/qS8A+PzT13PSsVN7Me8bcyd5+WFqcKnT5gfZ+e/
	 8hOxeWW5ROn6SXi21L0vf8KALTSN9LVs4cP5+NMyP+K2d06gi+Z39m9Pjaum3mIpJY
	 6Bq6OjEDKvCEEdImJc2+oqscrbZ7j/m4r0udrLyQ=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGCe0dc3947915
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 13:40:00 +0100
Received: (nullmailer pid 2275656 invoked by uid 1000);
	Thu, 16 Nov 2023 12:40:00 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC] usbnet: assign unique random MAC
Organization: m
References: <20231116123033.26035-1-oneukum@suse.com>
Date: Thu, 16 Nov 2023 13:39:59 +0100
In-Reply-To: <20231116123033.26035-1-oneukum@suse.com> (Oliver Neukum's
	message of "Thu, 16 Nov 2023 13:30:24 +0100")
Message-ID: <87ttplg9cw.fsf@miraculix.mork.no>
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

> A module parameter to go back to the old behavior
> is included.

Is this really required?  If we add it now then we can never get rid of
it.  Why not try without, and add this back if/when somebody complains
about the new behaviour?

I believe there's a fair chance no one will notice or complain.  And we
have much cleaner code and one module param less.


Bj=C3=B8rn

