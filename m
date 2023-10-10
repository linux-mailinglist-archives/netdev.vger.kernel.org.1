Return-Path: <netdev+bounces-39688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C517C40EA
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23641C20BA0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B429D08;
	Tue, 10 Oct 2023 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23B32196
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:11:53 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D62394
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:11:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38996)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqIdn-006dYJ-67; Tue, 10 Oct 2023 13:43:39 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41236 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqIT8-00Atq6-RJ; Tue, 10 Oct 2023 13:32:39 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,  David
 Ahern
 <dsahern@gmail.com>,  Stephen Hemminger <stephen@networkplumber.org>,
  "netdev@vger.kernel.org" <netdev@vger.kernel.org>,  Nicolas Dichtel
 <nicolas.dichtel@6wind.com>,  Christian Brauner <brauner@kernel.org>
References: <20231009182753.851551-1-toke@redhat.com>
	<877cnvtu37.fsf@email.froward.int.ebiederm.org>
	<6fc0ae94f5554c6ea320dba1d6fe84aa@AcuMS.aculab.com>
Date: Tue, 10 Oct 2023 14:32:31 -0500
In-Reply-To: <6fc0ae94f5554c6ea320dba1d6fe84aa@AcuMS.aculab.com> (David
	Laight's message of "Tue, 10 Oct 2023 08:42:32 +0000")
Message-ID: <87edi2jmsw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1qqIT8-00Atq6-RJ;;;mid=<87edi2jmsw.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19iOmKN4JTxsfxfeMYStTZ4J8QOHjrkg4o=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Laight <David.Laight@ACULAB.COM>
X-Spam-Relay-Country: 
X-Spam-Timing: total 517 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 8 (1.6%), b_tie_ro: 7 (1.4%), parse: 0.94 (0.2%),
	extract_message_metadata: 12 (2.4%), get_uri_detail_list: 1.55 (0.3%),
	tests_pri_-2000: 11 (2.0%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.29 (0.2%), tests_pri_-900: 1.02 (0.2%),
	tests_pri_-200: 0.86 (0.2%), tests_pri_-100: 3.7 (0.7%),
	tests_pri_-90: 140 (27.0%), check_bayes: 131 (25.4%), b_tokenize: 7
	(1.3%), b_tok_get_all: 7 (1.3%), b_comp_prob: 2.6 (0.5%),
	b_tok_touch_all: 111 (21.5%), b_finish: 1.04 (0.2%), tests_pri_0: 323
	(62.5%), check_dkim_signature: 0.87 (0.2%), check_dkim_adsp: 3.7
	(0.7%), poll_dns_idle: 0.37 (0.1%), tests_pri_10: 2.1 (0.4%),
	tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

David Laight <David.Laight@ACULAB.COM> writes:

> From: Eric W. Biederman
>> Sent: 09 October 2023 21:33
>>=20
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>> > The 'ip netns' command is used for setting up network namespaces with =
persistent
>> > named references, and is integrated into various other commands of ipr=
oute2 via
>> > the -n switch.
>> >
>> > This is useful both for testing setups and for simple script-based nam=
espacing
>> > but has one drawback: the lack of persistent mounts inside the spawned
>> > namespace. This is particularly apparent when working with BPF program=
s that use
>> > pinning to bpffs: by default no bpffs is available inside a namespace,=
 and
>> > even if mounting one, that fs disappears as soon as the calling
>> > command exits.
>>=20
>> It would be entirely reasonable to copy mounts like /sys/fs/bpf from the
>> original mount namespace into the temporary mount namespace used by
>> "ip netns".
>>=20
>> I would call it a bug that "ip netns" doesn't do that already.
>>=20
>> I suspect that "ip netns" does copy the mounts from the old sysfs onto
>> the new sysfs is your entire problem.
>
> When I was getting a program to run in multiple network namespaces
> (has sockets in 2 namespaces) I rather expected that netns(net_ns_fd,0)
> would 'magically' change /proc/net to refer to the new namespace.
> I think that could be done in the code that follows the /proc/net
> mountpoint - IIRC something similar is done for /proc/self.

/proc/self/net does follow your current network namespace last I looked.

Of course if you are threaded you may need to look at
/proc/thread-self/net as your network namespace is per thread.

It is also quite evil.  The problem is that having different entries
cached under the same name is a major mess.  Ever since I made that
mistake I have been aiming at designs that don't fight the dcache.

Even in that case I think I limited it to just a entry where
ugliness happens.

> However that would need flags to both setns() and 'ip netns exec'
> since programs will rely on the existing behaviour.

You might want to look again.=20=20

Eric

