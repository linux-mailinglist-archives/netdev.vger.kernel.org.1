Return-Path: <netdev+bounces-281057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFnpJtjP62nfRgAAu9opvQ
	(envelope-from <netdev+bounces-281057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910C463288
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 688793006127
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C2314D05;
	Fri, 24 Apr 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="QX9bI8gH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548D30E853
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061846; cv=pass; b=IRMBXiCdo3Yy58W7IaDqnbLrGfJtaAclpXVOC1TOw5zoFJEkfGGd5ch/IHencZair78v02QmoMpbk0VXKNyhfUWTnjYJO1JhWOpo04CLowH3EK7mLImIKpyBXFQ0wLt+/EJn0q/h5gFXpWxpnA+0Sge0yxDqfWXG43yTjAevQ58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061846; c=relaxed/simple;
	bh=MNoRpX3tTrMIoG+mlL68DWW91Ad1ceGWzt8V6/z7K+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=No7VLyeYBCs7g1tJEI+s65l3+9lvnLig72qdAQM78Z6LJsNEj/sy0q8ECvyoEqTzy6LlrYlD0KlaT2bH4o4JMsxo1nReGBlmZw/apcEsbZH17Ay3cezVyz67+YQvK9yHv0z6S0RvUZTWzfqcrNSFlI4lqQy3hzLlqcVEQE48SW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=QX9bI8gH; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296d553142so4779684b3a.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 13:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777061844; cv=none;
        d=google.com; s=arc-20240605;
        b=cBqDRDbwoWV1aJHIqghRDY8aR5oytTUA/OP2NIuIF06V23pjHrEOh/PgaoY5Ymo3Mu
         zynSor1TFZosqVpweam/7FDbeiqet4R21UBJWBJV67FwBA7DXVICwa2QzXJ1r1dL3QpL
         hKPpiLVlIcn5yP+z8GxhYFWSuAzpksZnKsUm008OMpoFkv5Rx1carQjGjtPTEzhzul8L
         JBYDAx8RIWzWXeFovU/D9YfQYPlVbRcrhcNofrcuty9/oRg4UlmcloWnrI6i98pLBgxi
         7NTDQ96x29jQ9ya7dUsivbIkYfkY/peHus/d5XCQtBjHhoI+7Hk9hgwXC5E/1mjNaa1o
         8LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Xy21txiMaq/93BRDdCcSXIbLDAgIvLUxwpvjBrYajM=;
        fh=zHALH12kKmoG9BxZp0W5Ett6//GS5lYpTOK/QI0pGvU=;
        b=B5pOcPlz8iplcV36iC9SePt6JORKbx9E7QagQ3YCTZggyckIYhIA4hotdJmASSO48f
         KVo3aoZUXSMGp4H3FN0nuRT8v8Kmeu8XGpZcXgslrxoqMHsalpe9PuyEZgthlBhHvsLY
         VIVbJrAys0q5XVZhjGJbdxgpdCI28UNm7+ho00HaUjRobjosU9+TjphNSe6WeajcEsVO
         m0UdFhwr/xzrOoD8YsusubJfeT69X604fzCd/TEfu7YKZ7tPojOXcWHws8oHGhIuPss+
         mKiAKjTzCNxNNhsP7Q8uHhgwSCDPU1OMHzKZdXm2E1IvgRkY+tRK2geOlESVvaHQztJB
         F1HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777061844; x=1777666644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xy21txiMaq/93BRDdCcSXIbLDAgIvLUxwpvjBrYajM=;
        b=QX9bI8gHuBZuwMDXTfIFGTzCgX6vZfeCftbW/CIWOHmYWYRisg2ptmd5v/yRe9KI9Q
         eiQCadhdXzURTuXJq70luqX0UQTTh6PBrCtKww51w1gC855sqA+Rvb1uCVd+oGNHwOZY
         lRBiNY2DpedkJVbJ59E8eIktJY9si6ZDf2UIioTzYmfr8aFUcJo3OFc5Fjlr1D7PKRm9
         Xma6LOQyHVhPtId56vmrNH6a7KLWCLaUet5/2tiPiukkbdC02mZdblKybgE36glaPoj7
         8I9O4fGTQ1Y52cHWGEBQ75eEk+n7jei+c5Smv23dBSKFlZQPEg4SdIZylamzlHgpVwC3
         2F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061844; x=1777666644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Xy21txiMaq/93BRDdCcSXIbLDAgIvLUxwpvjBrYajM=;
        b=I6lwMzDTm99wHuoKHobN+0FJbKu5QWBvzZMi72YYiyx5VglMrO3qcocghmiTYYW7Fx
         pKgJEHlOn7CeWbErx03Pz636CzvRPziH6kwuj3NqFp/oaxtrCNx4/uJV9FUw3caGdcKM
         ur86JjxTeXzJAs8ALw99yChmGmrD2TyZ6f51Z4KHjWL+xmuCGyWHyUPFNqPFGW0hkqBs
         aP3mlue+ZWCWZykx67TfTYilNSE5pUCYGcLzZLZsZW7B46uY4/VQGoS/B2JWDkPQ+ZJE
         o/qaSuLr+vdLsTDyaUX2ibJSI+yI2bbbzXJiojWpIvSu1Uhk2KQrxyNtRKYB4OIFkF8M
         K54w==
X-Forwarded-Encrypted: i=1; AFNElJ/0MrJv0AosN+TMIOsORCt+vUGb0l6rkFlaMXhMkaLcecR4afHjQmnUZfHAfgDlQfFb390o/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69o1FQG0E+OItKMSfDt00SQbhu6eNlz/hSxkk6R/GNr0pMuZi
	TLkZ1yPNLinqc5uEVLHkjE1ikXH+E8Sk91/5AKeSrR0zF4zcwiNU1SJZuWjBXCrx5AHjgVYty6Z
	puhWDTyzB/xNukOvgaSmhdZPuyqJhCyQcVlzAi7Zl
X-Gm-Gg: AeBDieskWLsdcLeby2Kn5TC+S2RYN/TqPHiorAkaEumlSilV29xQD/YGaBX3qP75F5m
	TLG7tWTzccFU9VvFZ9rA75+D70v3AZYglg67Iv+BYk19o2QhC8W46zSLTZxb2PBItpiCtimNmiB
	t9LaYjxHTPoq+t7a9j0sNpRIqmOOAjOCA//Bl0r7pVanPvijn+zj+8aINBdtZcJtFsccAvtKR/j
	Fx1p6XFGXL6GZiR7mG9j3oyfWHkQfNhEkijrxf18mcN3aFblCkVSY3PO1oHogc49t2fMf1qT60N
	8pnXZm6wZUrFpZ5SH/uLFU8lon3FeA==
X-Received: by 2002:a05:6a00:14c2:b0:82f:44dc:f85c with SMTP id
 d2e1a72fcca58-82f8c8d6ac2mr35344484b3a.34.1777061844163; Fri, 24 Apr 2026
 13:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418032027.900913-1-stephen@networkplumber.org>
 <20260418032027.900913-5-stephen@networkplumber.org> <20260421131039.GA651125@horms.kernel.org>
 <87f5e94e-d354-423d-9976-6cf3fb0710b1@redhat.com> <CAM0EoMmnHfUiKP1PO19sHJZpeGN5tdL7ds=_8Nma7Y-4XoSczg@mail.gmail.com>
 <20260424080700.6846dfcb@phoenix.local>
In-Reply-To: <20260424080700.6846dfcb@phoenix.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 24 Apr 2026 16:17:13 -0400
X-Gm-Features: AQROBzC6CmFEsrLFLq8fKIo-gq1NPlQp9Esbua18xCtm8sS68QkYgPERTaKC_LQ
Message-ID: <CAM0EoM=mtYFyVJYLRiFULX1hpxvcwpUoTDGJvTyAskyCk_Oehw@mail.gmail.com>
Subject: Re: [PATCH net v8 4/6] net/sched: netem: validate slot configuration
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, jiri@resnulli.us, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Dave Taht <dave.taht@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1910C463288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281057-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]

() ncalls s


On Fri, Apr 24, 2026 at 11:07=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 23 Apr 2026 17:12:15 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > > > This is intended and explicitly explained in the cover letter.
> > > Jamal, given the uAPI implication, could you please double check that
> > > the change is fine?
> > >
> >
> > It should be fine; at least iproute2 will never allow the kernel to
> > receive a negative number.
> > Stephen brought up the fact that strtod() could return a -ve number
> > (but at least iproute2 makes sure negative numbers are not carried
> > forward to the kernel).
> >
> > cheers,
> > jamal
>
> Iproute2 blocks negative values kind of by accident.
> The NEXT_IS_NUMBER() macro looks for digit at start of arg.
> To hit this you need to either use raw netlink or change NEXT_IS_NUMBER()
> to NEXT_IS_SIGNED_NUMBER() where slot values are parsed.

For this specific attribute it was intentional:
...
if (get_time64(&slot.dist_jitter, *argv)) { //get_time64 calls
strtod() which could set dist_jitter -ve
    explain1("slot jitter");
     return -1;
}
if (slot.dist_jitter <=3D 0) {  // we reject -ve values
    fprintf(stderr, "Non-positive jitter\n");
    return -1;
}

cheers,
jamal

