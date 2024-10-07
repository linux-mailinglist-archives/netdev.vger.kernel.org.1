Return-Path: <netdev+bounces-132887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56981993A11
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46BCB2366D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CA18C00C;
	Mon,  7 Oct 2024 22:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41323FB9F
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339577; cv=none; b=pWSbLTjCxVN4YfBEtEf0ebBCtCQnbgAWEq09HfFvzGZfOinKCFZqfA8OKsvJpWC6R8sILx8LmUY5R/pNbDAKnDWrvHV+BYcfQVx2IVdZp4oi5uiqT4vnOIwwhrV+lpau8MZviYdsw75m5/bYrj3k23wwSUxhPNfPKMJcMTq4qls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339577; c=relaxed/simple;
	bh=+vP315ZvfEs5R0eYQ0wr9WLvq1aLTKvP17aYZz/d2bk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=M1gqLhZNDanGahEdY5bw8vHi/i9I/nKiwpLRTFRvqZFKwVr/Hlo+mnYF3n79hWMMVMQnQT6ZqAtyLzh9oKf7s+Q3BL9xgK4UUgMXnUv+jqiWWlC2JUYusa9i5yFYgRBfNBInjv+NbpoMSwdZh8b/dr6h+vMgZWTrEA3hogOFlIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:44150)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sxw4k-00CMbz-BB; Mon, 07 Oct 2024 16:19:34 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:35658 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sxw4i-00ET1M-R9; Mon, 07 Oct 2024 16:19:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>,  <edumazet@google.com>,  <kuba@kernel.org>,
  <kuni1840@gmail.com>,  <netdev@vger.kernel.org>,  <pabeni@redhat.com>
References: <87v7y3g9no.fsf@email.froward.int.ebiederm.org>
	<20241007182106.39342-1-kuniyu@amazon.com>
Date: Mon, 07 Oct 2024 17:18:59 -0500
In-Reply-To: <20241007182106.39342-1-kuniyu@amazon.com> (Kuniyuki Iwashima's
	message of "Mon, 7 Oct 2024 11:21:06 -0700")
Message-ID: <8734l7d0a4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sxw4i-00ET1M-R9;;;mid=<8734l7d0a4.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19Eo68qq12ypR9eMly1lwpqiiJ8lC4iG/0=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4995]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kuniyuki Iwashima <kuniyu@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 663 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 12 (1.9%), b_tie_ro: 11 (1.6%), parse: 1.27
	(0.2%), extract_message_metadata: 16 (2.4%), get_uri_detail_list: 4.2
	(0.6%), tests_pri_-2000: 14 (2.1%), tests_pri_-1000: 2.7 (0.4%),
	tests_pri_-950: 1.34 (0.2%), tests_pri_-900: 1.12 (0.2%),
	tests_pri_-90: 122 (18.4%), check_bayes: 120 (18.1%), b_tokenize: 14
	(2.1%), b_tok_get_all: 43 (6.4%), b_comp_prob: 6 (0.9%),
	b_tok_touch_all: 54 (8.1%), b_finish: 1.03 (0.2%), tests_pri_0: 478
	(72.1%), check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 2.6
	(0.4%), poll_dns_idle: 0.72 (0.1%), tests_pri_10: 2.2 (0.3%),
	tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: pabeni@redhat.com, netdev@vger.kernel.org, kuni1840@gmail.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kuniyu@amazon.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Date: Mon, 07 Oct 2024 11:28:11 -0500
>> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
>> 
>> > From: "Eric W. Biederman" <ebiederm@xmission.com>
>> > Date: Mon, 07 Oct 2024 09:56:44 -0500
>> >> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
>> >> 
>> >> > Since introduced, mpls_init() has been ignoring the returned
>> >> > value of rtnl_register_module(), which could fail.
>> >> 
>> >> As I recall that was deliberate.  The module continues to work if the
>> >> rtnetlink handlers don't operate, just some functionality is lost.
>> >
>> > It's ok if it wasn't a module.  rtnl_register() logs an error message
>> > in syslog, but rtnl_register_module() doesn't.  That's why this series
>> > only changes some rtnl_register_module() calls.
>> 
>> You talk about the series.  Is there an introductory letter I should
>> lookup on netdev that explains things in more detail?
>> 
>> I have only seen the patch that is sent directly to me.
>
> Some context here.
> https://lore.kernel.org/netdev/20241007124459.5727-1-kuniyu@amazon.com/
>
> Before addf9b90de22, rtnl_register_module() didn't actually need
> error handling for some callers, but even after the commit, some
> modules copy-and-pasted the wrong code.

That is wrong. As far back as commit e284986385b6 ("[RTNL]: Message
handler registration interface") it was possible for rtnl_register to
error.  Of course that dates back to the time when small allocations
were guaranteed to succeed or panic the kernel.  So I expect it was
the change to small allocations that actually made it possible to
see failures from rtnl_register.

That said there is a difference between code that generates an error,
and callers that need to handle the error.  Even today I do not
see that MPLS needs to handle the error.

Other than for policy objectives such as making it harder for
syzkaller to get confused, and making the code more like other
callers I don't see a need for handling such an error in MPLS.

>> > What if the memory pressure happend to be relaxed soon after the module
>> > was loaded incompletely ?
>> 
>> Huh?  The module will load completely.  It will just won't have full
>> functionality.  The rtnetlink functionality simply won't work.
>> 
>> > Silent failure is much worse to me.
>> 
>> My point is from the point of view of the MPLS functionality it isn't
>> a __failure__.
>
> My point is it _is_ failure for those who use MPLS rtnetlink
> functionality, it's uAPI.  Not everyone uses the plain MPLS
> without rtnetlink.

No matter what the code does userspace attempting to use rtnetlink to
configure mpls will fail.  Either the MPLS module will fail to load, and
nothing works, or the module will load and do the best it can with what
it has.  Allowing the folks you don't need the rtnetlink uAPI to
succeed.

It isn't a uAPI failure.  It is a lack of uAPI availability.  There
is nothing else it can be.

In general the kernel tries to limp along the best it can without
completely failing.

> Also, I don't want to waste resource due to such an issue on QEMU w/ 2GB
> RAM where I'm running syzkaller and often see OOM.  syzkaller searches
> and loads modules and exercises various uAPIs randomly, and it handles
> module-load-failure properly.

Then please mention that use case in your change description.  That is
the only real motivation I see to for this change in behavior. Perhaps
something like:

    Handler errors from rtnetlink registration allowing syzkaller to view a
    module as an all or nothing thing in terms of the functionality it
    provides.  This prevents syzkaller from reporting spurious errors
    from it's tests.

That seems like a fine motivation and a fine reason.  But if you don't
say that, people will make changes that don't honor that, and people
won't be able to look into the history and figure out why such a change
was made.

Recording the real reasons for changes in the history really matters.
Because sometimes people need to revisit things, and if you don't
include those reasons people don't have a chance of taking your reaons
into account when the revisit a change for another set of reasons.
Unless somehow someone remembers something when it comes to code review
time.


>> The flip side is I tried very hard to minimize the amount of code in
>> af_mpls, to make maintenance simpler, and to reduce the chance of bugs.
>> You are busy introducing what appears to me to be an untested error
>> handling path which may result in something worse that not logging a
>> message.  Especially when someone comes along and makes another change.
>> 
>> It is all such a corner case and I really don't care, but I just don't
>> want this to be seen as a change that is obviously the right way to go
>> and that has no downside.
>
> I don't see how this small change has downside that affects maintenability.
> Someone who wants to add a new code there can just add a new function call
> and goto label, that's simple enough.

Strictly speaking when testing code both branches of every if statement
need to be tested.  It is the untested code where mistakes slip in.
People being human we don't get it right 100% of the time.

It isn't a large maintenance cost increase, but it is a maintenance cost
increase.

One if statement isn't a big deal but at the end of the day it adds up.

If code becomes simpler and there is noticeably less for it to do the
code winds up having measurably fewer bugs.  If code becomes more
complex, with more cases to handle and more branches after a time code
winds up having measurably more bugs.

When I look at any part of the linux kernel with which I am familiar I
can very much guarantee that most of it has become more complex over
time, leading to measurably more bugs.   Tools like syzkaller help, but
that don't completely compensate for more complex code.



In this case I expect in balance fewer spurious errors from syzkall
is seems like it would be a net win.  But I most definitely see a
tradeoff being made here.

Eric


