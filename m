Return-Path: <netdev+bounces-186743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B86AA0D9D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6BD4676A7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4B2D1F74;
	Tue, 29 Apr 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b="GmeLQZ0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACEF2C2AC8
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934096; cv=none; b=gSvtYN92eQkidN5CcuhATiQ+CxZNS/W6AhiOf3CrSjazFnoCJWkzCljqLeLxDJD6VgC3CnAa3to1iy0awjKmNM+yOGMs/GQ6r4zdR3LlE7XuGCebguQWDThWa40lF5FFNoILzK6gFFw+D2cDxaYxEXsxV9kQRdnUAl6K0N0V6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934096; c=relaxed/simple;
	bh=FbLQN++8XrYxCWc7f00ETR7/f2G1tEbjbbvM1AokLTQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i28fiIkC1jw2mNVTlW/Iy3fXz60FBUscC2sR0FwZl+UbJzfCN80LB0NS2EUb3UmHcbpLQQXNElsAA8HlJJFU6+THW2EquW4PCHKw5PKKNmJWoCzDU1VlnITivCWITFTnMdAH0QZpQ7+LEc7iaiFGxZKT4CrDGfJfgB21Za4tbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io; spf=pass smtp.mailfrom=syst3mfailure.io; dkim=pass (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b=GmeLQZ0h; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syst3mfailure.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syst3mfailure.io;
	s=protonmail2; t=1745934083; x=1746193283;
	bh=JjUmW77xKhN7h+ALaHwcjyJXu3OU7GgSJ9M/6/iovrs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GmeLQZ0h98VxaB7fzHHIiZNUTwqeR9DbJQEgMREwk9pqr+rjtioRaXMx7r8nRUEWO
	 OStxg3oVSgmYa1mQlxXnjbmHn/zGg7d5xrA8VsQGn3jo2ipnLn7cetopPrZfNq+NrQ
	 fwA/E+2rIN9Lv9OZ1TNNRym8it4Q1l2h/Cz5+Ri1eX6x47dw4BoD8s16iIw7wKtkwY
	 n5YF+SQZW7XddAJx+LPRQHKChIcJUQm5jFq1plgYwDtqJOjPpuxM4rvRosMjymq2Wt
	 +b+7BQkQVq1qENc8tWXczB4REhkvgSPxvQhmpSdr7D7sbGXlZCfU6JBo9mnpm83j0r
	 nKIek5pPuJUrA==
Date: Tue, 29 Apr 2025 13:41:19 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: Savy <savy@syst3mfailure.io>
Cc: Will <willsroot@protonmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [BUG] net/sched: Race Condition and Null Dereference in codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <EBHeQZeq5AJteszZoHrsiJv6EGOnuByQ-XNejgA9WiqQ8g2jIXowzoGjuJowDcV6xi9xBgyMTwNlS8wN0zUOlRl4Bl2Mv-x883IKCvdySyU=@syst3mfailure.io>
In-Reply-To: <aA/czQYEtPmMim0G@pop-os.localdomain>
References: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com> <aA1kmZ/Hs0a33l5j@pop-os.localdomain> <B2ZSzsBR9rUWlLkrgrMrCzqOGeSFxXIkYImvul6994v5tDSqykWo1UaWKRV-SNkNKJurgVzRcnPN07ZAVYykRaYhADyIwTxQ18OQfKDpILQ=@protonmail.com> <aA/czQYEtPmMim0G@pop-os.localdomain>
Feedback-ID: 69690694:user:proton
X-Pm-Message-ID: 0c96cae8ae674ff75774ab21355bcd13c41a41ca
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Monday, April 28th, 2025 at 7:53 PM, Cong Wang <xiyou.wangcong@gmail.com=
> wrote:

>=20
>=20
> Excellent analysis!
>=20
> Do you mind testing the following patch?
>=20
> Note:
>=20
> 1) We can't just test NULL, because otherwise we would leak the skb's
> in gso_skb list.
>=20
> 2) I am totally aware that maybe there are some other cases need the
> same fix, but I want to be conservative here since this will be
> targeting for -stable. It is why I intentionally keep my patch minimum.
>=20
> Thanks!
>=20
> --------------->
>=20

Hi Cong,

Thank you for the reply. We have tested your patch and can confirm that it =
resolves the issue.
However, regarding point [1], we conducted some tests to verify if there is=
 a skb leak in the gso_skb list,=20
but the packet remains in the list only for a limited amount of time.

In our POC we set a very low TBF rate, so when the Qdisc runs out of tokens=
,=20
it reschedules itself via qdisc watchdog after approximately 45 seconds.

Returning to the example above, here is what happens when the watchdog time=
r fires:

[ ... ]

Packet 2 is sent:

    [ ... ]

    tbf_dequeue()
        qdisc_peek_dequeued()
            skb_peek(&sch->gso_skb) // sch->gso_skb is empty
            codel_qdisc_dequeue() // Codel qlen is 1
                qdisc_dequeue_head()
                // Packet 2 is removed from the queue
                // Codel qlen =3D 0
            __skb_queue_head(&sch->gso_skb, skb); // Packet 2 is added to g=
so_skb list
            sch->q.qlen++ // Codel qlen =3D 1

        // TBF runs out of tokens and reschedules itself for later
        qdisc_watchdog_schedule_ns()=20

    codel_change() // Patched, (!skb) break;, does not crash

    // ... ~45 seconds later the qdisc watchdog timer fires

    tbf_dequeue()
        qdisc_peek_dequeued()
            skb_peek(&sch->gso_skb) // sch->gso_skb is _not_ empty (contain=
s Packet 2)
        // TBF now has enough tokens
        qdisc_dequeue_peeked()
            skb =3D __skb_dequeue(&sch->gso_skb) // Packet 2 is removed fro=
m the gso_skb list
            sch->q.qlen-- // Codel qlen =3D 0

Notice how the gso_skb list is correctly cleaned up when the watchdog timer=
 fires.
We also examined some edge cases, such as when the watchdog is canceled=20
and there are still packets left in the gso_skb list, and it is always clea=
ned up:

Qdisc destruction case:

    tbf_destroy()
        qdisc_put()
            __qdisc_destroy()
               qdisc_reset()
                   __skb_queue_purge(&qdisc->gso_skb);

Qdisc reset case:

    tbf_reset()
        qdisc_reset()
            __skb_queue_purge(&qdisc->gso_skb);

Perhaps the skb leak you mentioned occurs in another edge case that we over=
looked?=20
In any case, we believe your patch is technically more correct,
as it makes sense to clean up packets in the gso_skb list first when the li=
mit changes.

Best regards,
Savy
Will

