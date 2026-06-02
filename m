Return-Path: <netdev+bounces-294044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDRzCbF7HmrejQkAu9opvQ
	(envelope-from <netdev+bounces-294044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:44:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6162921B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77CA1301F333
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768733A839B;
	Tue,  2 Jun 2026 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT5GJ3ly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6F3A7F58
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382284; cv=pass; b=HZ87dCjb9x3ff8seY/OO2ldlHpDT1EnWjFC9YTax5JtDaPjlqvZRjKP5J9rtl/1Jb4PGMuC8bF6FbWDoB17K0JvhfAKe3A9P+eB1J8DkX3xYkOcW81F6Dt20i99DtfafPRIEK/gou0SvjF/lMyc7hoOYqjXFt0JUzS+fKEvAPHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382284; c=relaxed/simple;
	bh=JbxGCQikWsjtiU448LSzqt9IDhzgB3hvRcjsRFezC48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM/msJyhuE+q4JftRZolsgXKdV8HWLB9/ZXlY+PnUb3praTztfHXkLh/kVP0+bWrtHZ6d4aI0rV0XrlD2voLnSBLiNGLslZyN6Ib7yMeUqBjRQwtkTd09EJas6vtrQUrtPkLbOgeNxWzK9yQSlIHNUze/LoSYQrg+25EgQzJ3eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT5GJ3ly; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so2320118a91.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 23:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780382281; cv=none;
        d=google.com; s=arc-20240605;
        b=dd89RM3lqDv16sZqO69EKmEVWNeigsCTnSpxaUW4Ptd7bvMG8OtcqQ+br1TgAd6hw9
         t7CPF8ZcHwQQ8rtP+dK6fjZ5OPGPx6GK1Ou8IAcFt4yr/TE7i516lSvm2JRTSVEK5I2i
         fbTR4i6CG+O7pfN8O/+1lUew4K+59vleQW6Seh58GbEeKrrv+L+NhDkN5lQ1jE38JPkp
         /7GDdBB1TWRj37n6HvqX94156cTEZtmP54wWNUTboX3KpimSIYUNVZg77yFwwqbuw+qF
         qzK89f+f2QxIkKluNO0CDh0+ffUsZeD80Rn6Zu6KwUmDHRYhhsLeSlSDs+dnJYAMgugd
         m0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7nLSxnJo2ojzbc9ZCEria5uzbpX3eTCBAbiyI5bsEg=;
        fh=VTF/UxVakzPrSrZgCIKthz4pJJRvTnnGfFF26kYSrZI=;
        b=JhsEgJ1K+FSgWBtCLmXXcqFX1MiSk2QYmJOzVr76ynImd8nbnSRRQInxuIyzzcxFdq
         vhylbpdetGQpykdQdlhYd6z93jkO+LEjHMRtpOYoik9L1CaH94/DtYQ+RY2UfhXXqvXF
         0/1Cp4tHwfQpxQNxTcpWmiOd7R84tr5CjyQ0bEPeDW5P1H5jR3/ToBa++xi1fFfYQAdy
         p30IRfycwWE/j1t0b1ZvrCh5yPSqPCf3uKHOWhutFm2NR1WDXMRlkaC+URRMqIgK8vsS
         pXr0EbcopWkc2ZIOxYfnVjOYzAYa0C/PB4UvSAaYzDsae5JdNGsYI+ePwDWyvgdOQzGk
         UsDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780382281; x=1780987081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7nLSxnJo2ojzbc9ZCEria5uzbpX3eTCBAbiyI5bsEg=;
        b=MT5GJ3lyQMxU5HJM0gLo2iy9aIEvA3diKaV2nt3K0mdAovOy8GTutYamenHk30sHnO
         jQGuk8f4VkOSqWuJzTyptm6F8VrPbd5N/uIVT18kGYuu0tNNILRuEY79qqqbnZumx58z
         3ChFbLf8b4QC5BFTOztlvVtnenmpa5nf07gneoIeOaVZbAfE8Eg5fPNHGXquQu6rVNRs
         dcMlJaV3z0oxGPzObXrYHSfEDNJ60YcFReDoQokO8aK6gWPvg6bOTQx/1ZfK/2AlgPgm
         PbjpodKy6hl8bfHdUHxaToLeBSPGOYDW7HIEfmiiuC3pawJ1RtjtVIWNqbCgJu9SOw+8
         vs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780382281; x=1780987081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7nLSxnJo2ojzbc9ZCEria5uzbpX3eTCBAbiyI5bsEg=;
        b=NKc4OHRSONRL+SiukOG9H5IKwwrHJzm4GSs8jRBop2rq0mNxUMVtboj9cVPlPQgOo7
         M+tFSalsdZlO52fUcr08nh3VSXm7ghsZLn6DF8zYulnScPSY+P5uR1OKczUeqprZgiBN
         V1xTJtzRmXdk7FB8FCVJc0Y/rIGMuF4zylqVQ/phfpuwznaMEfTwmwALoOX2E0UL74bY
         XM+Wuk1GUPUARNXH9PWOlQWGXrJfJyx3S3YH6KEXgnDYFyvIzzvcfH0SVhFQhM46LkjD
         mUQvds4SE9tz9Bk5FoYQB7HTQ2GlN/B3PYmj0co9Ar8/Rn/1LCfjKdOOam0S12I8E+/P
         EJHA==
X-Forwarded-Encrypted: i=1; AFNElJ/4H/5Fzs3Nw4cdaYi2ZhMLjPdYKif0B2BmJBwzwQyxRBKplO9jBCF/CRNR/6YvSEUv3J3jCpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvDXyBeAn8R2rEjKjCAa4zILrU+MSf3GO684MAESJSSZa/rED
	cOvzgEK40jd1kHBc5MYJsHfRKKCoon9gPzgq+yppg5Z8gctun0eDRLTWcpr/w+m8EPCbhOmbq+R
	wPHd1sniHQBHHa2Jasgc1hSl2ab6azAc=
X-Gm-Gg: Acq92OE9JXrGLv+dGhdd7O6a2mYTqQnUNzoBBFTn8EIaoqC84yPXUb4RJu8WB2FR+hq
	alGLjaB1rLMSy6lFSYew/ctimx4iQqUovutryfybUS4V8Fg1JSz0BVF2TQcEYe2Q7IdQ+RIXmX0
	yMN2gzRleMgBBn7VFt5+9grUfKwFg5qyTg+Vo/Wa+XrV/eYM/R0m1tBIRvXAyHE/Hhp2rbpUMxg
	FJwiMiwxcaOJEy9v2Z8UgKaU9lHjoYWpdpfm/pdkcCm/igYFESnDXq9uFFBkPXC+rmBEdiRTncw
	75AuawRnEzvfWuekxp0=
X-Received: by 2002:a17:90b:2747:b0:36b:9c70:3367 with SMTP id
 98e67ed59e1d1-36c501e8716mr14091662a91.17.1780382281075; Mon, 01 Jun 2026
 23:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch> <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
 <8f7eb9c7-6695-450c-81c4-fb96643adbc2@lunn.ch> <CAD03fja5oG3-BrQoy4+LEmCWPYGW_JWDEkaPndjSVz=PbRj4wg@mail.gmail.com>
 <2026060202-wad-skittle-263f@gregkh>
In-Reply-To: <2026060202-wad-skittle-263f@gregkh>
From: Grewstad <dogestad24@gmail.com>
Date: Tue, 2 Jun 2026 12:07:48 +0530
X-Gm-Features: AVHnY4KvCpb-kqDRYenuUh8abdPrvzxl2AJlcWi_F64K9qRgblLI8vRI3yS8KdM
Message-ID: <CAD03fjaHmsYpLj_PU48AW7h=E6XdMpqKsS7wQtDQKnEkGpa93g@mail.gmail.com>
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem direction
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, jic23@kernel.org, jacobsfeder@gmail.com, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294044-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dogestad24@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 92B6162921B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 2, 2026 at 11:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> If no one is using it, why don't we just delete it then?  It can come
> back if someone shows a real use-case for it.

Yes, this is what i was thinking. These boards are generally used for
development and research teams can probably maintain a patch if
they really want it. As you said, it can always come back if a
user-space application depends on it.

One drawback that comes to mind is a development group may
currently be maintaining a proprietary application that depends on it.

Thanks,
Arihan Bhor

